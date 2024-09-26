//
//  Pokemons.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation

/// Pokemons model is list of `Pokemon` which is returned by **poke api** (endpoint: pokemon?limit=100000&offset=0.)
public struct Pokemons: Codable, Equatable {
    public static func == (lhs: Pokemons, rhs: Pokemons) -> Bool {
        lhs.count == rhs.count && lhs.next == rhs.next && lhs.previous == rhs.previous && lhs.results == rhs.results
    }
    
    public init(count: Int, next: String?, previous: String?, results: [Pokemon]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    public let count:Int
    public let next:String?
    public let previous:String?
    public let results:[Pokemon]
}
