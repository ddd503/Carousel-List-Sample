//
//  ListViewPresenter.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

protocol ListViewPresenterInterface: class {
    func reload()
    func showErrorAlert(title: String?, message: String?, action: ((UIAlertAction) -> ())?)
    func transitionDetailVC(shopData: Shop)
}

final class ListViewPresenter: BaseInterface {
    
    weak var interface: ListViewPresenterInterface?
    let datasource = ListViewDatasource()
    var rests = [Rest]()
    var tappedObjectData: TappedObjectData?
    let navigationBarHeight = UIApplication.shared.statusBarFrame.height + 44
    var tableViewScrollOffsetY: CGFloat = 0
    
    deinit {
        destroyInterface()
    }
    
    func requestDatasource() {
        datasource.getDatasource(localFileName: "rest")
    }
    
    func didTapCell(listViewCell: ListViewCell, carouCell: CarouCell, restIndex: Int, shopIndex: Int, cellFrame: CGRect) {
        tappedObjectData = TappedObjectData(imageFrame: CGRect(x: cellFrame.origin.x,
                                                               y: cellFrame.origin.y + listViewCell.categoryLabel.frame.size.height + 20,
                                                               width: cellFrame.size.width,
                                                               height: cellFrame.size.height -
                                                                carouCell.shopNameLabel.frame.size.height),
                                            labelFrame: CGRect(x: cellFrame.origin.x,
                                                               y: cellFrame.origin.y + listViewCell.categoryLabel.frame.size.height + 20 + carouCell.shopImageView.frame.size.height,
                                                               width: cellFrame.size.width,
                                                               height: cellFrame.size.height - listViewCell.categoryLabel.frame.size.height - 20 - carouCell.shopImageView.frame.size.height),
                                            image: carouCell.shopImageView.image, text: carouCell.shopNameLabel.text)
        interface?.transitionDetailVC(shopData: rests[restIndex].shops[shopIndex])
    }
    
}

extension ListViewPresenter: ListViewDatasourceInterface {
    
    func receivedRests(_ rests: [Rest]) {
        self.rests = rests
        interface?.reload()
    }
    
    func failuerRequest(error: Error) {
        interface?.showErrorAlert(title: "オフライン", message: "通信環境が良い場所で再度起動してください", action: nil)
    }
    
}
