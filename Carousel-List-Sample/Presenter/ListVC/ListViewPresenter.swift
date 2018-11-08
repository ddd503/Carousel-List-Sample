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
}

final class ListViewPresenter: BaseInterface {
    
    weak var interface: ListViewPresenterInterface?
    let datasource = ListViewDatasource()
    var rests = [Rest]()
    
    func requestDatasource() {
        datasource.getDatasource(localFileName: "rest")
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
