//
//  FetchPokemonDetailsUseCaseTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 26/9/24.
//

import XCTest

final class FetchPokemonDetailsUseCaseTests: XCTestCase {
    var useCase:FetchPokemonDetailsUseCase!
    let apiManager =  MockAPIManager(.list1)

    override func setUpWithError() throws {
        useCase = FetchPokemonDetailsUseCase(repository: apiManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchPokemonDetailsOutput() async throws {
        let pokemonDetails = try await useCase.execute(pokemon: Pokemon(name: "name", url: "url"))
        XCTAssertEqual(pokemonDetails.baseExperience, apiManager.pokemonDetails.baseExperience)
        XCTAssertEqual(pokemonDetails.weight, apiManager.pokemonDetails.weight)
        XCTAssertEqual(pokemonDetails.height, apiManager.pokemonDetails.height)
    }
    
    func testFetchPokemonDetailsError() async throws {
        useCase = FetchPokemonDetailsUseCase(repository: MockErrorAPIManager())
        do {
            _ = try await useCase.execute(pokemon: Pokemon(name: "name", url: "url"))
        } catch {
            XCTAssert(error as? MockErrorAPIManager.MockError == MockErrorAPIManager.MockError.mock)
        }
    }

}
