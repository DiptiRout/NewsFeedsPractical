//
//  FavouriteCollectionViewController.swift
//  NewsFeedsPractical
//
//  Created by Muvi on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import RealmSwift

class FavouriteCollectionViewController: UICollectionViewController {

    let dbManager = DataBaseManager()
    var articleData: Results<ArticleObject>!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        articleData = dbManager.realm.objects(ArticleObject.self)
        print(articleData)
        
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
        detailsPageVC.articleObject = articleData[indexPath.item]
        detailsPageVC.vcID = "FavouriteCollectionViewController"
        navigationController?.pushViewController(detailsPageVC, animated: false)
    }
}
