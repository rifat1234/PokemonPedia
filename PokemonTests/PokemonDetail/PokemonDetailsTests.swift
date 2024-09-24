//
//  PokemonDetailsTests.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 24/9/24.
//

import XCTest

final class PokemonDetailsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPokemonDetailsDecode() throws {
        let json = SampleJSONs.bulbasaurDetails
        let data = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let pokemonDetails = try decoder.decode(PokemonDetails.self, from: data)
            XCTAssertNotNil(pokemonDetails)
        } catch {
            XCTAssertTrue(false, "Failed to decode JSON")
        }
    }

}
