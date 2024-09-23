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

    func testPokemonDecode() throws {
        let json = """
        {"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"}
        """
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            let testPokemon = Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(testPokemon, pokemon)
        } catch {
            XCTAssertTrue(false, "Failed to decode JSON")
        }
    }
    
    func testPokemonDashReplaceWithSpace() throws {
        let json = """
        {"name":"bulbasaur-pikachu","url":"https://pokeapi.co/api/v2/pokemon/1/"}
        """
        
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            let testPokemon = Pokemon(name: "Bulbasaur Pikachu", url: "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(testPokemon, pokemon)
        } catch {
            XCTAssertTrue(false, "Failed to decode JSON")
        }
    }
    
    func testPokemonImageURL() throws {
        let pokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        let testImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        XCTAssertEqual(testImageURL, pokemon.imageURL)
    }
    
    func testPokemonsDecode() throws {
        let json = """
        {"count":2,"next":null,"previous":null,"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"},{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon/2/"}]}
        """
        
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let pokemons = try decoder.decode(Pokemons.self, from: data)
            let testPokemons = Pokemons(count: 2, next: nil, previous: nil, results: [
                Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                Pokemon(name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
            ])
            XCTAssertEqual(testPokemons, pokemons)
        } catch {
            XCTAssertTrue(false, "Failed to decode JSON")
        }
    }

}
