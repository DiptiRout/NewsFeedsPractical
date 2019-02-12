//
//  HeadLinesModel.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import Foundation
import UIKit

struct HeadLinesModel: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [ArticleModel]?

    init(status: String, totalResults: Int, articles: [ArticleModel]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

struct ArticleModel: Codable {
    var title: String?
    var urlToImage: URL?
    var description: String?
    var publishedAt: String?
}
