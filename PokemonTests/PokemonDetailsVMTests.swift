//
//  PokemonDetailsTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 29/6/24.
//

import XCTest

final class PokemonDetailsVMTests: XCTestCase {
    var viewModel:PokemonDetailsView.ViewModel!
    var testPokemonDetails:PokemonDetails!
    
    override func setUpWithError() throws {
        let apiManager =  MockAPIManager(allPokemon: [])
        testPokemonDetails = apiManager.pokemonDetails
        viewModel = PokemonDetailsView.ViewModel(Pokemon(name: "name", url: "url"), apiManager: apiManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchPokemonDetails() async throws {
        await viewModel.fetchPokemonDetails()
        XCTAssertEqual(testPokemonDetails.baseExperience, viewModel.baseExperience)
        XCTAssertEqual(testPokemonDetails.weight, viewModel.weight)
        XCTAssertEqual(testPokemonDetails.height, viewModel.height)
    }
    
    func testFetchPokemonDetailsError() async throws {
        viewModel = PokemonDetailsView.ViewModel(Pokemon(name: "name", url: "url"), apiManager: MockErrorAPIManager())
        await viewModel.fetchPokemonDetails()
        XCTAssertTrue(viewModel.showAlert)
    }
    
    func testViewStateChange() async throws {
        XCTAssertEqual(viewModel.viewState, .dataLoading)
        await viewModel.fetchPokemonDetails()
        XCTAssertEqual(viewModel.viewState, .dataLoaded)
    }
}
