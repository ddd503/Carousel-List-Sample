//
//  ViewControllerBuilder.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class ViewControllerBuilder {
    
    /// ListVC
    static func buildListVC() -> ListViewController {
        let vcName = "ListViewController"
        let vc = UIStoryboard(name: vcName, bundle: Bundle.main).instantiateViewController(withIdentifier: vcName) as! ListViewController
        vc.presenter = ListViewPresenter()
        vc.presenter.applyInterface(terget: vc)
        vc.presenter.datasource.applyInterface(terget: vc.presenter)
        return vc
    }
    
    /// DetailVC
    static func buildDetailVC() -> DetailViewController {
        let vcName = "DetailViewController"
        let vc = UIStoryboard(name: vcName, bundle: Bundle.main).instantiateViewController(withIdentifier: vcName) as! DetailViewController
        vc.presenter = DetailViewPresenter()
        vc.presenter.applyInterface(terget: vc)      
        return vc
    }
    
    /// 表示中の画面(UIViewController)を取得する（最前面）
    ///
    /// - Returns: 表示中の画面(失敗した場合はnilを返す)
    static func topVC() -> UIViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            return topViewController
        } else {
            return nil
        }
    }
    
}
