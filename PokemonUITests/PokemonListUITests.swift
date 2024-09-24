//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Rifat Monzur on 23/9/24.
//

import XCTest

final class PokemonListUITests: XCTestCase {
    var app: XCUIApplication!
    let timeout: TimeInterval = 2
    let pokemonName = "Bulbasaur"

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = [AppLaunchMode.uiTesting.rawValue]
        
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testIfPokemonListExist() throws {
        app.launch()
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        
        // Check if pokemon list exist
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
    }
    
    @MainActor
    func testPokemonListCells() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let listNum = SamplePokemonList.list1
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        // sort the pokemon list in alphabetical order
        let pokemons = listNum.list.sorted { $0.name < $1.name }
        // check if all the cells are present
        XCTAssertTrue(pokemonList.cells.count == pokemons.count)
        
        // check if all the cells are in correct alphabetical order
        for i in 0..<pokemons.count {
            let cell = pokemonList.cells.element(boundBy: i)
            let firstPokemon = cell.staticTexts[pokemons[i].name]
            XCTAssert(firstPokemon.waitForExistence(timeout: timeout))
        }
        
    }
    
    @MainActor
    func testSearchOnPokemonList() throws {
        let listNum = SamplePokemonList.list2
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        // Find the searchbar
        let pokemonSearchBar = app.searchFields.firstMatch
        // Check for the searchbar existance
        XCTAssert(pokemonSearchBar.waitForExistence(timeout: timeout))
        pokemonSearchBar.tap()
        pokemonSearchBar.typeText(pokemonName) // type pokemon name
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        // Check for pokemon list existance
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
        // Only one cell should be present after the search
        XCTAssert(pokemonList.cells.count == 1)
        let cell = pokemonList.cells.firstMatch
        // Check if the right cell is presented
        let firstPokemon = cell.staticTexts[pokemonName]
        XCTAssert(firstPokemon.waitForExistence(timeout: timeout))
    }
    
}
