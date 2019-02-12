//
//  FavouriteCollectionViewController.swift
//  NewsFeedsPractical
//
//  Created by Muvi on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import RealmSwift
import NVActivityIndicatorView

class FavouriteCollectionViewController: UICollectionViewController {

    let dbManager = DataBaseManager()
    var article: ArticleModel!
    var articleData: Results<ArticleObject>!
    var activityIndicatorView: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)        
    }
    override func viewWillAppear(_ animated: Bool) {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .ballClipRotate, color: #colorLiteral(red: 0.04787462205, green: 0.3609589934, blue: 0.1635327637, alpha: 1), padding: 5)
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        articleData = dbManager.realm.objects(ArticleObject.self)
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
        activityIndicatorView.stopAnimating()

    }

}

extension FavouriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCell", for: indexPath as IndexPath) as! FavouriteCell
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
        article = ArticleModel(title: articleData[indexPath.item].title,
                               description: articleData[indexPath.item].newsDescription,
                               publishedAt: articleData[indexPath.item].publishedAt)
        detailsPageVC.article = article
        detailsPageVC.articleObject = articleData[indexPath.item]
        detailsPageVC.vcID = "FavouriteCollectionViewController"
        navigationController?.pushViewController(detailsPageVC, animated: false)
    }
}
