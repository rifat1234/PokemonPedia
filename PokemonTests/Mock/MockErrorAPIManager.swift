//
//  MockErrorAPIManager.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation

struct MockErrorAPIManager: APIManagerProtocol {
    enum MockError: Error{
        case mock
    }
    
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        throw MockError.mock
    }

    func fetchAllPokemon() async throws -> [Pokemon] {
        throw MockError.mock
    }
    
    func downloadFile(url: String, completion: ((URL?) -> ())?) {
    }
}
