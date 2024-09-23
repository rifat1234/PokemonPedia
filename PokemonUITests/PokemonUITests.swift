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
        app.launchArguments = [AppLaunchMode.uiTesting.rawValue]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    @MainActor
    func testIfPokemonListExist() throws {
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
    }
    
    @MainActor
    func testPokemonListCells() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let listNum = SamplePokemonList.list1
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        let pokemons = listNum.list.sorted { $0.name < $1.name }
        XCTAssertTrue(pokemonList.cells.count == pokemons.count)
        
        for i in 0..<pokemons.count {
            let cell = pokemonList.cells.element(boundBy: i)
            let firstPokemon = cell.staticTexts[pokemons[i].name]
            XCTAssert(firstPokemon.waitForExistence(timeout: timeout))
        }
        
    }
    
    @MainActor
    func testPokemonDetailsFlow() throws {
        let listNum = SamplePokemonList.list2
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
        XCTAssert(pokemonList.cells.count == 2)
        let cell = pokemonList.cells.element(boundBy: 0)
        cell.tap()
        
        let pokemonTitle = app.staticTexts["Bulbasaur"]
        XCTAssert(pokemonTitle.waitForExistence(timeout: timeout))
    }
    
    @MainActor
    func testPokemonDetailsWithSearchBar() throws {
        let listNum = SamplePokemonList.list2
        app.launchArguments.append(listNum.rawValue)
        app.launch()

        let pokemonSearchBar = app.searchFields.firstMatch
        XCTAssert(pokemonSearchBar.waitForExistence(timeout: timeout))
        pokemonSearchBar.tap()
        pokemonSearchBar.typeText("Bulbasaur")
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
        
        XCTAssert(pokemonList.cells.count == 1)
        let cell = pokemonList.cells.firstMatch
        cell.tap()
        
        let pokemonTitle = app.staticTexts["Bulbasaur"]
        XCTAssert(pokemonTitle.waitForExistence(timeout: timeout))
    }
}
