//
//  APIController.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import Foundation
import UIKit

class APIController: NSObject {
    
    let apiKey = "5c6ee09a978942e4b2e37f78c90780c3"
    let baseUrl = "https://newsapi.org"
    let endPoint = "/v2/top-headlines"
// https://newsapi.org/v2/top-headlines?country=us&apiKey=5c6ee09a978942e4b2e37f78c90780c3
// https://newsapi.org/v2/everything?q=bitcoin&apiKey=5c6ee09a978942e4b2e37f78c90780c3
    
    func getTopHeadLines(countryCode: String, completion: @escaping (_ result: Bool, _ newsData: HeadLinesModel)->()) {
        let url = URL(string: "\(baseUrl)\(endPoint)?country=\(countryCode)&apiKey=\(apiKey)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let newsData = HeadLinesModel(status: "Fail", totalResults: 0, articles: [])
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            guard let data = data else{
                return completion(false, newsData)
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(HeadLinesModel.self, from: data)
                return completion(true, responseModel)

            } catch let error{
                print(error.localizedDescription)
                return completion(false, newsData)
            }
        }).resume()
    }
    
}
