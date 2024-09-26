//
//  MockAPIManager.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

import Foundation
import PokemonCore

struct MockAPIManager: PokemonRepository {
    let allPokemon:[Pokemon]
    
    let pokemonDetails = PokemonDetails(abilities: nil, baseExperience: 12, cries: nil, forms: nil, gameIndices: nil, height: 10, heldItems: nil, id: nil, isDefault: nil, locationAreaEncounters: nil, moves: nil, name: nil, order: nil, pastAbilities: nil, pastTypes: nil, species: nil, sprites: nil, stats: nil, types: nil, weight: 120)
    
    
    init(_ listType: SamplePokemonList? = nil) {
        allPokemon = listType?.list ?? []
    }
    
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        if url == "https://pokeapi.co/api/v2/pokemon/1/" {
            let json = SampleJSONs.bulbasaurDetails
            let data = Data(json.utf8)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonDetails.self, from: data)
        }
            
        return pokemonDetails
    }
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        allPokemon
    }
    
    func downloadFile(url: String, completion: ((URL?) -> ())?) {
        
    }
}
