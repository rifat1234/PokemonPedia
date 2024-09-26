//
//  FetchPokemonListUseCaseTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 26/9/24.
//

import XCTest

final class FetchPokemonListUseCaseTests: XCTestCase {
    var useCase:FetchPokemonListUseCase!

    override func setUpWithError() throws {
        let apiManager =  MockAPIManager(.list1)
        useCase = FetchPokemonListUseCase(repository: apiManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAllPokemonWithAlphabeticalOrder() async throws {
        let pokemons = try await useCase.execute()
        
        let testResult = [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
            Pokemon(name: "pika", url: "url3"),
        ]
        
        XCTAssertEqual(testResult, pokemons)
    }
    
    func testFetchAllPokemonError() async throws {
        useCase = FetchPokemonListUseCase(repository: MockErrorAPIManager())
        do {
            _ = try await useCase.execute()
        } catch {
            XCTAssert(error as? MockErrorAPIManager.MockError == MockErrorAPIManager.MockError.mock)
        }
    }

    func testSearchResult() async throws {
        let pokemons1 = try await useCase.execute(searchTerm: "a")
        let testResult1 = [
            Pokemon(name: "aab", url: "url1"),
            Pokemon(name: "abc", url: "url2"),
        ]
        
        XCTAssertEqual(testResult1, pokemons1)
        
        let pokemons2 = try await useCase.execute(searchTerm: "aa")
        let testResult2 = [
            Pokemon(name: "aab", url: "url1")
        ]
        
        XCTAssertEqual(testResult2, pokemons2)
    }

}
