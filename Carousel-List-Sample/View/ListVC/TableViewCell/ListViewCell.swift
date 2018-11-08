//
//  ListViewCell.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/09.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class ListViewCell: UITableViewCell {

    @IBOutlet weak var carouselListView: UICollectionView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselListView.register(UINib(nibName: CarouCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: CarouCell.identifier)
        carouselListView.register(UINib(nibName: TitleHeaderView.identifier, bundle: nil),
                                  forCellWithReuseIdentifier: TitleHeaderView.identifier)
        carouselListView.showsHorizontalScrollIndicator = false
    }

    func setDatasource(_ datasource:
        UICollectionViewDelegate & UICollectionViewDataSource) {
        carouselListView.delegate = datasource
        carouselListView.dataSource = datasource
        DispatchQueue.main.async {
            self.carouselListView.reloadData()
        }
    }
    
}
