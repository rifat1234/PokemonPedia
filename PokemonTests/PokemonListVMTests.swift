//
//  PokemonListVMTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 28/6/24.
//

import XCTest

final class PokemonListVMTests: XCTestCase {
    var viewModel:PokemonListView.ViewModel!

    override func setUpWithError() throws {
        let apiManager =  MockAPIManager(allPokemon: [
            Pokemon(name: "abc", url: "url2"),
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "pika", url: "url3")
        ])
        
        viewModel = PokemonListView.ViewModel(apiManger: apiManager)
    }

    override func tearDownWithError() throws {
        
    }
    
    func testFetchAllPokemonWithAlphabeticalOrder() async throws {
        await viewModel.fetchAllPokemons()
        
        let testResult = [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
            Pokemon(name: "pika", url: "url3"),
        ]
        
        XCTAssertEqual(testResult, viewModel.searchedPokemons)
    }
    
    func testFetchAllPokemonError() async throws {
        viewModel = PokemonListView.ViewModel(apiManger: MockErrorAPIManager())
        await viewModel.fetchAllPokemons()
        XCTAssertTrue(viewModel.showAlert)
    }

    func testSearchResult() async throws {
        await viewModel.fetchAllPokemons()
        
        viewModel.searchText = "a"
        let testResult1 = [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
        ]
        
        XCTAssertEqual(testResult1, viewModel.searchedPokemons)
        
        viewModel.searchText = "aa"
        let testResult2 = [
            Pokemon(name: "aab", url: "url1")
        ]
        
        XCTAssertEqual(testResult2, viewModel.searchedPokemons)
    }

    func testViewStateChange() async throws {
        XCTAssertEqual(viewModel.viewState, .dataLoading)
        await viewModel.fetchAllPokemons()
        XCTAssertEqual(viewModel.viewState, .dataLoaded)
    }
        
}
