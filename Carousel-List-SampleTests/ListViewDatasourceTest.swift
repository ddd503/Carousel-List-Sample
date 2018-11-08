//
//  ListViewDatasourceTest.swift
//  Carousel-List-SampleTests
//
//  Created by kawaharadai on 2018/11/08.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import XCTest
@testable import Carousel_List_Sample

class ListViewDatasourceTest: XCTestCase {
    
    var expectation = XCTestExpectation()
    
    func test_requestDatasource_localのjsonファイルからデータソースを作成するテスト() {
        expectation = self.expectation(description: "get&parse test")
        let datasource = ListViewDatasource()
        datasource.interface = self
        datasource.getDatasource(localFileName: "rest")
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func test_requestDatasource_データソース作成失敗をハンドリングするテスト() {
        expectation = self.expectation(description: "get&parse fuiler handle test")
        let datasource = ListViewDatasource()
        datasource.interface = self
        datasource.getDatasource(localFileName: "test")
        self.waitForExpectations(timeout: 10, handler: nil)
    }

}

extension ListViewDatasourceTest: ListViewDatasourceInterface {
    
    func receivedRests(_ rests: [Rest]) {
        expectation.fulfill()
        XCTAssertNotNil(rests)
        XCTAssertFalse(rests.isEmpty)
        XCTAssertNotNil(rests.first!.title)
        XCTAssertNotNil(rests.first!.shops.first!.name)
        XCTAssertNotNil(rests.first!.shops.first!.address)
        XCTAssertNotNil(rests.first!.shops.first!.tel)
        XCTAssertNotNil(rests.first!.shops.first!.budget)
        XCTAssertNotNil(rests.first!.shops.first!.shop_image1)
    }
    
    func failuerRequest(error: Error) {
        expectation.fulfill()
        XCTAssertNotNil(error)
    }
    
}
