//
//  PokemonDetailsUITests.swift
//  PokemonUITests
//
//  Created by Rifat Monzur on 24/9/24.
//

import XCTest

final class PokemonDetailsUITests: XCTestCase {
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
    func testPokemonDetailsFlow() throws {
        let listNum = SamplePokemonList.list2
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        // Check for pokemon list existance
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
        // Check if all the pokemon are present in the list
        XCTAssert(pokemonList.cells.count == listNum.list.count)
        let cell = pokemonList.cells.element(boundBy: 0)
        cell.tap()
        
        // Check if details are showing of right pokemon
        let pokemonTitle = app.navigationBars.staticTexts[pokemonName]
        XCTAssert(pokemonTitle.waitForExistence(timeout: timeout))
    }
    
    @MainActor
    func testPokemonDetailsMoreInfoFlow() throws {
        let listNum = SamplePokemonList.list2
        app.launchArguments.append(listNum.rawValue)
        app.launch()
        
        let pokemonList = app.collectionViews[PokemonListView.Const.pokemonListAccessibilityID]
        // Check for pokemon list existance
        XCTAssert(pokemonList.waitForExistence(timeout: timeout))
        // Check if all the pokemon are present in the list
        XCTAssert(pokemonList.cells.count == listNum.list.count)
        let cell = pokemonList.cells.element(boundBy: 0)
        cell.tap()
        
        // Check if details are showing of right pokemon
        let pokemonTitle = app.navigationBars.staticTexts[pokemonName]
        XCTAssert(pokemonTitle.waitForExistence(timeout: timeout))
        
        
        let moreInfoCellName = "Forms"
        let formsMoreInfoCell = app.collectionViews.cells.staticTexts[moreInfoCellName]
        
        // Scroll down until cell found
        while (!formsMoreInfoCell.exists) {
            app.swipeUp()
        }
        XCTAssertTrue(formsMoreInfoCell.isHittable)
        formsMoreInfoCell.tap()
        
        // Check if right more info are showing
        let moreInfoTitle = app.navigationBars.staticTexts[moreInfoCellName]
        XCTAssert(moreInfoTitle.waitForExistence(timeout: timeout))
        
        
    }
    
    @MainActor
    func testPokemonDetailsWithSearchBar() throws {
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
        cell.tap()
        
        // Check if the right cell is presented in details
        let pokemonTitle = app.staticTexts[pokemonName]
        XCTAssert(pokemonTitle.waitForExistence(timeout: timeout))
    }
}
