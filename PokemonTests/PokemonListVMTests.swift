//
//  PokemonListVMTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 28/6/24.
//

import XCTest

final class PokemonListVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchResult() async throws {
        let apiManager = MockAPIManager(allPokemon: [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
            Pokemon(name: "pika", url: "url3"),
        ])
        
        let viewModel = PokemonListView.ViewModel(apiManger: apiManager)
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

}
