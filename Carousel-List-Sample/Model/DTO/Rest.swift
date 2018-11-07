//
//  Rest.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

struct Rest: Codable {
    var title = ""
    let shops: [Shop]
}

struct Shop: Codable {
    var name = ""
    var address = ""
    var tel = ""
    var budget = ""
    var shop_image1 = ""
}
