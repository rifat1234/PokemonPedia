//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Rifat Monzur on 23/9/24.
//

import XCTest

final class PokemonUITests: XCTestCase {
    var app: XCUIApplication!
    let timeout: TimeInterval = 2

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launchArguments = ["Testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    @MainActor
    func testIfPokemonListExist() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
    }
    
    @MainActor
    func testPokemonListCells() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        
        let pokemons = SamplePokemonList.list1.sorted{ $0.name < $1.name }
        
        XCTAssertTrue(pokemonList.cells.count == pokemons.count)
        
        for i in 0..<pokemons.count {
            let cell = pokemonList.cells.element(boundBy: i)
            let firstPokemon = cell.staticTexts[pokemons[i].name]
            XCTAssert(firstPokemon.waitForExistence(timeout: timeout))
        }
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
