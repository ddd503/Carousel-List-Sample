//
//  TitleHeaderView.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/09.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class TitleHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
}
