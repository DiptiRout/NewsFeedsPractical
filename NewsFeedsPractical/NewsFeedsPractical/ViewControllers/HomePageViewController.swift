//
//  HomePageViewController.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 11/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import RealmSwift
import NVActivityIndicatorView

class HomePageViewController: UICollectionViewController {
    
    let controller = APIController()
    var articleData = [ArticleModel]()
    let dbManager = DataBaseManager()
    var activityIndicatorView: NVActivityIndicatorView!


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        setRightNavBarItem()
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .ballClipRotate, color: #colorLiteral(red: 0.04787462205, green: 0.3609589934, blue: 0.1635327637, alpha: 1), padding: 5)
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        callNewsFeedsApi()
    }
    @objc func showFavItems(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "NewsFeeds", bundle: nil)
        let detailsPageVC = storyboard.instantiateViewController(withIdentifier: "FavouriteCollectionViewController") as! FavouriteCollectionViewController
        navigationController?.pushViewController(detailsPageVC, animated: false)
    }
    func setRightNavBarItem() {
        
        let rightNavBarItem = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(showFavItems(_:)))
        self.navigationItem.rightBarButtonItem = rightNavBarItem
    }
    func callNewsFeedsApi() {
        controller.getTopHeadLines(countryCode: "us", completion: { (result, newsData) -> () in
            DispatchQueue.main.async {
                if result {
                    self.articleData = newsData.articles ?? []
                    self.collectionView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                }
                else {
                    print(result)
                }
            }
        })
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedCell", for: indexPath as IndexPath) as! NewFeedCell
        cell.articleData = articleData[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "NewsFeeds", bundle: nil)
        let detailsPageVC = storyboard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        detailsPageVC.vcID = "HomePageViewController"
        detailsPageVC.article = articleData[indexPath.item]
        navigationController?.pushViewController(detailsPageVC, animated: false)
    }
}
