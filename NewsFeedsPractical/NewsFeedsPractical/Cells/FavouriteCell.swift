//
//  FavouriteCell.swift
//  NewsFeedsPractical
//
//  Created by Muvi on 12/02/19.
//  Copyright © 2019 Dipti. All rights reserved.
//

import UIKit
import Kingfisher

class FavouriteCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var captionLabel: UILabel!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    var articleData: ArticleObject? {
        didSet {
            if let news = articleData {
                captionLabel.text = news.title
                imageView.image = UIImage(data: news.urlToImage)
            }
        }
    }
}
