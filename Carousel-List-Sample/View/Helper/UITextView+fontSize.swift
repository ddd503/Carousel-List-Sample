//
//  UITextView+fontSize.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/14.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

extension UITextView {
    /// 画面縦幅に合わせてフォントサイズを変更する(ListView用)
    func adjustFontForListView() {
        switch Double(UIScreen.main.bounds.size.height) {
        case (let height) where height <= 568.0: // 5S系
            self.font = UIFont.systemFont(ofSize: 10)
        case (let height) where height <= 667.0: // 6系
            self.font = UIFont.systemFont(ofSize: 12)
        case (let height) where height <= 736.0: // 6Puls系
            self.font = UIFont.systemFont(ofSize: 13)
        case (let height) where height <= 812.0: // X系
            self.font = UIFont.systemFont(ofSize: 15)
        case (let height) where height <= 896.0: // XMax系
            self.font = UIFont.systemFont(ofSize: 17)
        default:
            self.font = UIFont.systemFont(ofSize: 17)
        }
    }
    /// 画面縦幅に合わせてフォントサイズを変更する(ListView用)
    func adjustFontForDetailView() {
        switch Double(UIScreen.main.bounds.size.height) {
        case (let height) where height <= 568.0: // 5S系
            self.font = UIFont.boldSystemFont(ofSize: 18)
        case (let height) where height <= 667.0: // 6系
            self.font = UIFont.boldSystemFont(ofSize: 20)
        case (let height) where height <= 736.0: // 6Puls系
            self.font = UIFont.boldSystemFont(ofSize: 21)
        case (let height) where height <= 812.0: // X系
            self.font = UIFont.boldSystemFont(ofSize: 23)
        case (let height) where height <= 896.0: // XMax系
            self.font = UIFont.boldSystemFont(ofSize: 23)
        default:
            self.font = UIFont.systemFont(ofSize: 23)
        }
    }
}
