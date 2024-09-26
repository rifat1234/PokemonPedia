//
//  InfoVMTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 30/6/24.
//

import XCTest
import PokemonCore

final class InfoVMTests: XCTestCase {
    var infoVM:InfoDataView.ViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        infoVM = InfoDataView.ViewModel(infoData: InfoData(type: .abilities,
                                    infos:[Info(name: "B", url: "url2"),
                                           Info(name: "A", url: "url1"),
                                           Info(name: "C", url: "url3")]))
    }

    override func tearDownWithError() throws {
        infoVM = nil
    }

    func testNavigationTitle() throws {
        XCTAssertEqual(InfoData.DataType.abilities.title, infoVM?.navigationTitle)
    }
    
    func testInfoListSort() throws {
        let testInfos = [Info(name: "A", url: "url1"),
                         Info(name: "B", url: "url2"),
                         Info(name: "C", url: "url3")]
        
        XCTAssertEqual(testInfos, infoVM?.sortedInfo)
    }
}
