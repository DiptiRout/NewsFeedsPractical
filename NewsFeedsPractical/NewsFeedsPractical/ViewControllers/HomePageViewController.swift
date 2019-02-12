//
//  HomePageViewController.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 11/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import RealmSwift

class HomePageViewController: UICollectionViewController {
    
    let controller = APIController()
    var articleData = [ArticleModel]()
    let dbManager = DataBaseManager()

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
        callNewsFeedsApi()
    }
    func callNewsFeedsApi() {
        controller.getTopHeadLines(countryCode: "us", completion: { (result, newsData) -> () in
            DispatchQueue.main.async {
                if result {
                    self.articleData = newsData.articles ?? []
                    self.collectionView.reloadData()
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
