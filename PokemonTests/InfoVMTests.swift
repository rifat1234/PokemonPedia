//
//  InfoVMTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 30/6/24.
//

import XCTest

final class InfoVMTests: XCTestCase {
    var infoVM:InfoView.ViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        infoVM = InfoView.ViewModel(infos: [Info(name: "B", url: "url2"),
                                           Info(name: "A", url: "url1"),
                                           Info(name: "C", url: "url3")],
                                    title: "title")
    }

    override func tearDownWithError() throws {
        infoVM = nil
    }

    func testNavigationTitle() throws {
        XCTAssertEqual("Title", infoVM?.navigationTitle)
    }
    
    func testInfoListSort() throws {
        let testInfos = [Info(name: "A", url: "url1"),
                         Info(name: "B", url: "url2"),
                         Info(name: "C", url: "url3")]
        
        XCTAssertEqual(testInfos, infoVM?.sortedInfo)
    }
}
