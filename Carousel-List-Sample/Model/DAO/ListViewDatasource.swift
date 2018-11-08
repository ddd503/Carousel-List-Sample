//
//  ListViewDatasource.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import Foundation

protocol ListViewDatasourceInterface: class {
    func receivedRests(_ rests: [Rest])
    func failuerRequest(error: Error)
}

final class ListViewDatasource: BaseInterface {
    
    weak var interface: ListViewDatasourceInterface?
    
    func getDatasource(localFileName: String) {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: getLocalJsonFilePath(fileName: localFileName)))
            let decoder = JSONDecoder()
            let rests = try decoder.decode([Rest].self, from: jsonData)
            interface?.receivedRests(rests)
        } catch let error {
            interface?.failuerRequest(error: error)
        }
    }
    
    /// lacalのjsonファイルのpathを取得
    ///
    /// - Parameter fileName: ファイル名
    /// - Returns: jsonファイルのpath(失敗の場合はnil)
    func getLocalJsonFilePath(fileName: String) -> String {
        return Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
    }

}
