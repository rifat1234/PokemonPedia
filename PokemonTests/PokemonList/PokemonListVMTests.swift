//
//  PokemonListVMTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 28/6/24.
//

import XCTest
import PokemonCore

final class PokemonListVMTests: XCTestCase {
    var viewModel:PokemonListView.ViewModel!

    override func setUpWithError() throws {
        let apiManager =  MockPokemonRepo(.list1)
        viewModel = PokemonListView.ViewModel(fetchPokemonListUseCase: FetchPokemonListUseCase(repository: apiManager))
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
        viewModel = PokemonListView.ViewModel(fetchPokemonListUseCase: FetchPokemonListUseCase(repository: MockErrorAPIManager()))
        await viewModel.fetchAllPokemons()
        XCTAssertTrue(viewModel.showAlert)
    }

    func testSearchResult() async throws {
        viewModel.searchText = "a"
        await viewModel.fetchAllPokemons()

        let testResult1 = [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
        ]
        
        XCTAssertEqual(testResult1, viewModel.searchedPokemons)
        
        viewModel.searchText = "aa"
        await viewModel.fetchAllPokemons()
        
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
