//
//  ListViewPresenter.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

protocol ListViewPresenterInterface: class {
//    func reload()
}

final class ListViewPresenter: BaseInterface {
    
    weak var interface: ListViewPresenterInterface?
    let datasource = ListViewDatasource()
    var rests = [Rest]()
}

extension ListViewPresenter: ListViewDatasourceInterface {
    
    func receivedRests(_ rests: [Rest]) {
        self.rests = rests
    }
    
    func failuerRequest(error: Error) {
        
    }
    
}
