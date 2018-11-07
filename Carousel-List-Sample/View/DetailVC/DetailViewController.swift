//
//  DetailViewController.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    var presenter: DetailViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension DetailViewController: DetailViewPresenterInterface {}
