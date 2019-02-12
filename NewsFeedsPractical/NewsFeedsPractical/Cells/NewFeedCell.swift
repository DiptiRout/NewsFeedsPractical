//
//  NewFeedCell.swift
//  NewsFeedsPractical
//
//  Created by Dipti on 11/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import Kingfisher

class NewFeedCell: UICollectionViewCell {
  
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var captionLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    var articleData: ArticleModel? {
    didSet {
      if let news = articleData {
        captionLabel.text = news.title
        if let url = news.urlToImage {
            imageView.kf.setImage(with: url)

        }
      }
    }
  }
}
