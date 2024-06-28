//
//  File.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation

struct MockAPIManager: APIManagerProtocol {
    let allPokemon:[Pokemon]
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        allPokemon
    }
}
