//
//  File.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation

struct MockAPIManager: APIManagerProtocol {
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        PokemonDetails(id: 132, name: "ditto", baseExperience: 101, height: 3, weight: 40)
    }
    
    let allPokemon:[Pokemon]
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        allPokemon
    }
}
