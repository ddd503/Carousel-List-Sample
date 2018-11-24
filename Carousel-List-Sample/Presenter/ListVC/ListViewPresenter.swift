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
    var tableViewCellHeight: CGFloat = 0
    var collectionViewCellSize: CGSize?
    var collectionViewCurrentOffsetXDic = [String: NSNumber]()
    
    deinit {
        destroyInterface()
    }
    
    func requestDatasource() {
        datasource.getDatasource(localFileName: "rest01")
    }
    
    func didTapCell(_ carouCell: CarouCell, restIndex: Int, shopIndex: Int, parentView: UIView?) {
        let imageFrame = carouCell.convert(carouCell.shopImageView.frame, to: parentView)
        let textFrame = carouCell.convert(carouCell.shopNameTextView.frame, to: parentView)
        tappedObjectData = TappedObjectData(imageFrame: imageFrame,
                                            textFrame: textFrame,
                                            image: carouCell.shopImageView.image, text: carouCell.shopNameTextView.text)
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
