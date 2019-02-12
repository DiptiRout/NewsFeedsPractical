//
//  DataBaseManager.swift
//  NewsFeedsPractical
//
//  Created by Muvi on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public class ArticleObject: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var urlToImage = Data()
    @objc dynamic var newsDescription = ""
    @objc dynamic var publishedAt = ""
}

public class DataBaseManager {
    
    public init() {
    }
    var realm: Realm = try! Realm()
    
    public func makeNewArticle(_ title: String, urlToImage: Data, newsDescription: String, publishedAt: String ) -> ArticleObject
    {
        let newarticle = ArticleObject()
        newarticle.title = title
        newarticle.urlToImage = urlToImage
        newarticle.newsDescription = newsDescription
        newarticle.publishedAt = publishedAt
        return newarticle
    }
    
    public func saveArticle(_ object: ArticleObject) throws
    {
        try! realm.write {
            realm.add(object)
        }
    }
    public func findArticleByTitle(_ title: String) throws -> Results<ArticleObject>
    {
        let predicate = NSPredicate(format: "title = %@", title)
        return realm.objects(ArticleObject.self).filter(predicate)
        
    }
    
    public func deleteArticle(_ article: ArticleObject) throws {
        
        
        let predicate = NSPredicate(format: "title == %@", article.title)
        let targetArticles = realm.objects(ArticleObject.self).filter(predicate)
        var objects = targetArticles.makeIterator()
        while let object = objects.next() {
            try! realm.write {
                realm.delete(object)
            }
        }
        
    }
}
