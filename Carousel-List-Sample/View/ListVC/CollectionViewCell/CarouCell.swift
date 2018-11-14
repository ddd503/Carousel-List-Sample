//
//  CarouCell.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/09.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit
import Kingfisher

final class CarouCell: UICollectionViewCell {
    
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var tappedView: UIView!
    @IBOutlet weak var shopNameTextView: UITextView! {
        didSet {
            shopNameTextView.font = UIFont.systemFont(ofSize: FontSizeHelper.listViewFontSize())
            shopNameTextView.textContainer.maximumNumberOfLines = 2
            shopNameTextView.textContainerInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
            shopNameTextView.textContainer.lineBreakMode = .byTruncatingTail
        }
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setCellData(data: Shop) {
        shopNameTextView.text = data.name
        if let imageUrl = URL(string: data.shop_image1) {
            shopImageView.kf.setImage(with: imageUrl)
        } else {
            shopImageView.image = UIImage(named: "DefaultImage")
        }
    }
    
}
