//
//  ListViewCell.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/09.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var carouselListView: UICollectionView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselListView.register(CarouCell.nib(), forCellWithReuseIdentifier: CarouCell.identifier)
        carouselListView.showsHorizontalScrollIndicator = false
    }
    
    func setViewData(datasource:
        UICollectionViewDelegate & UICollectionViewDataSource, categoryTitle: String, tag: Int, currentOffsetX: CGFloat?) {
        carouselListView.delegate = datasource
        carouselListView.dataSource = datasource
        categoryLabel.text = categoryTitle
        carouselListView.tag = tag
        carouselListView.contentOffset.x = currentOffsetX ?? 0
        carouselListView.reloadData()
    }
    
}
