//
//  MockAPIManager.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

import Foundation

struct MockAPIManager: APIManagerProtocol {
    let allPokemon:[Pokemon]
    
    let pokemonDetails = PokemonDetails(abilities: nil, baseExperience: 12, cries: nil, forms: nil, gameIndices: nil, height: 10, heldItems: nil, id: nil, isDefault: nil, locationAreaEncounters: nil, moves: nil, name: nil, order: nil, pastAbilities: nil, pastTypes: nil, species: nil, sprites: nil, stats: nil, types: nil, weight: 120)
    
    
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        pokemonDetails
    }
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        allPokemon
    }
    
    func downloadFile(url: String, completion: ((URL?) -> ())?) {
        
    }
}
