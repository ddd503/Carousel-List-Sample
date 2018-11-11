//
//  DetailViewController.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, TransitionType {
    
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.masksToBounds = true
            closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        }
    }
    
    var presenter: DetailViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
    }
    
    @IBAction func close(_ sender: UIButton) {
        presenter.didTapCloseButton()
    }
    
}

extension DetailViewController: DetailViewPresenterInterface {
    
    func display() {
        addressLabel.text = presenter.shop.address
        telLabel.text = presenter.shop.tel
        budgetLabel.text = "\(presenter.shop.budget)円"
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}
