//
//  CarouCell.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/09.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class CarouCell: UICollectionViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setCellData(data: Shop) {
        shopNameLabel.text = data.name
        // 現状仮で表示
        shopImageView.image = UIImage(named: "DefaultImage")
    }

}
