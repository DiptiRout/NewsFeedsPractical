//
//  FeedDetailsViewController.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import Foundation
import Kingfisher
import RealmSwift

class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favButton: FaveButton!
    
    var articleObject = ArticleObject()
    let dbManager = DataBaseManager()
    var vcID = ""
    var imageFromFav = UIImage()
    
    public var article: ArticleModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        if vcID == "FavouriteCollectionViewController" {
            setUpDataFromFavPage()
        }
        else {
            setUpDataFromHomePage()
        }
    }
    func setUpDataFromHomePage() {
        do {
            let object = try dbManager.findArticleByTitle(article.title ?? "")
            if object.isEmpty {
                favButton.setSelected(selected: false, animated: false)
            }
            else {
                favButton.setSelected(selected: true, animated: false)
            }
        }
        catch{
            
        }
        bannerImageView.kf.setImage(with: article.urlToImage)
        nameLabel.text = article.title
        dateLabel.text = article.publishedAt
        descriptionLabel.text = article.description
    }
    func setUpDataFromFavPage() {
        do {
            let object = try dbManager.findArticleByTitle(articleObject.title)
            if object.isEmpty {
                favButton.setSelected(selected: false, animated: false)
            }
            else {
                favButton.setSelected(selected: true, animated: false)
            }
        }
        catch{
            
        }
        bannerImageView.image = UIImage(data: articleObject.urlToImage)
        nameLabel.text = articleObject.title
        dateLabel.text = articleObject.publishedAt
        descriptionLabel.text = articleObject.newsDescription
    }
}

extension FeedDetailsViewController: FaveButtonDelegate {
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        if selected {
            saveData()
        }
        else {
            if vcID == "FavouriteCollectionViewController" {
                deleteDataFav()
            }
            else {
                deleteDataHome()
            }
        }
    }
    
    func saveData() {
        var iData = Data()
        do {
            if let newsImageUrl = article.urlToImage {
                let imageData = try Data(contentsOf: newsImageUrl as URL)
                iData = imageData
            }
            
            articleObject = dbManager.makeNewArticle(article.title ?? "",
                                                         urlToImage: iData,
                                                         newsDescription: article.description ?? "",
                                                         publishedAt: article.publishedAt ?? "")
            let object = try dbManager.findArticleByTitle(article.title ?? "")
            if object.isEmpty {
                try dbManager.saveArticle(articleObject)
            }
            else {
            }
            
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
    
    func deleteDataFav() {
        do {
            let object = try dbManager.findArticleByTitle(articleObject.title)
            if object.isEmpty {
            }
            else {
                try dbManager.deleteArticle(articleObject)
            }
        }
        catch {
            
        }
    }
    func deleteDataHome() {
        do {
            let object = try dbManager.findArticleByTitle(article.title ?? "")
            if object.isEmpty {
            }
            else {
                try dbManager.deleteArticle(articleObject)
            }
        }
        catch {
            
        }
    }
    
}
