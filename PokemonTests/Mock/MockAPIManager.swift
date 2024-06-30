//
//  File.swift
//  PokemonTests
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation

struct MockAPIManager: APIManagerProtocol {
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        PokemonDetails(abilities: nil, baseExperience: nil, cries: nil, forms: nil, gameIndices: nil, height: nil, heldItems: nil, id: nil, isDefault: nil, locationAreaEncounters: nil, moves: nil, name: nil, order: nil, pastAbilities: nil, pastTypes: nil, species: nil, sprites: nil, stats: nil, types: nil, weight: nil)
    }
    
    let allPokemon:[Pokemon]
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        allPokemon
    }
}
