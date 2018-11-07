//
//  BaseInterface.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

public protocol BaseInterface: class {
    associatedtype TergetObject
    var interface: TergetObject? { get set }
    func applyInterface(terget: TergetObject)
    func destroyInterface()
}

extension BaseInterface {
    /// - Parameter terget: 任意のInterfaceを準拠させるクラス
    public func applyInterface(terget: TergetObject) {
        interface = terget
    }
    /// インスタンスを破棄する（相互参照防止）
    public func destroyInterface() {
        interface = nil
    }
}
