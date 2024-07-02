//
//  Pokemons.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation

/// Pokemons model is list of `Pokemon` which is return by **poke api** (endpoint: pokemon?limit=100000&offset=0.)
struct Pokemons: Codable, Equatable {
    static func == (lhs: Pokemons, rhs: Pokemons) -> Bool {
        lhs.count == rhs.count && lhs.next == rhs.next && lhs.previous == rhs.previous && lhs.results == rhs.results
    }
    
    let count:Int
    let next:String?
    let previous:String?
    let results:[Pokemon]
}
