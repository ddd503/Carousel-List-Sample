//
//  AlertHelper.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/08.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class AlertHelper {
    
    /// OKと表示するのみのアラートを表示する
    ///
    /// - Parameters:
    ///   - title: タイトル
    ///   - message: メッセージ
    ///   - action: タップ時のアクション
    static func showDefaultErrorAlert(title: String? = "エラー", message: String?, action: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: action)
        alert.addAction(alertAction)
        guard let vc = ViewControllerBuilder.topVC() else { return }
        vc.present(alert, animated: true)
    }
}
