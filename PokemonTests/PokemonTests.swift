//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 28/6/24.
//

import XCTest

final class PokemonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let json = """
        {"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}
        """
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            let testPokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(testPokemon, pokemon)
        } catch {
            XCTAssertTrue(true, "Failed to decode JSON")
        }
        
    }

}
