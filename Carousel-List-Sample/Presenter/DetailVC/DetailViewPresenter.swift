//
//  DetailViewPresenter.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

protocol DetailViewPresenterInterface: class {
    func display()
    func dismiss()
}

final class DetailViewPresenter: BaseInterface {
    
    weak var interface: DetailViewPresenterInterface?
    var shop = Shop()
    
    deinit {
        destroyInterface()
    }
    
    func setup() {
        interface?.display()
    }
    
    func didTapCloseButton() {
        interface?.dismiss()
    }
    
}

