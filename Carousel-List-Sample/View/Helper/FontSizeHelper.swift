//
//  FontSizeHelper.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/14.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import Foundation
import UIKit

final class FontSizeHelper {
    
    /// 画面縦幅に合わせてフォントサイズを変更する(ListView用)
    static func listViewFontSize() -> CGFloat {
        switch Double(UIScreen.main.bounds.size.height) {
        case (let height) where height <= 568.0: // 5S系
            return 10
        case (let height) where height <= 667.0: // 6系
            return 12
        case (let height) where height <= 736.0: // 6Puls系
            return 13
        case (let height) where height <= 812.0: // X系
            return 15
        case (let height) where height <= 896.0: // XMax系
            return 17
        default:
            return 17
        }
    }
    
    /// 画面縦幅に合わせてフォントサイズを変更する(DetailView用)
    static func detailViewFontSize() -> CGFloat {
        switch Double(UIScreen.main.bounds.size.height) {
        case (let height) where height <= 568.0: // 5S系
            return 18
        case (let height) where height <= 667.0: // 6系
            return 20
        case (let height) where height <= 736.0: // 6Puls系
            return 21
        case (let height) where height <= 812.0: // X系
            return 23
        case (let height) where height <= 896.0: // XMax系
            return 23
        default:
            return 23
        }
    }
    
}
