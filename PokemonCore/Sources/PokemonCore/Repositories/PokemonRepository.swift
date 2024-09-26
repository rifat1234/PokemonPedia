//
//  APIManager.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation

public protocol PokemonRepository {
    func fetchAllPokemon() async throws ->[Pokemon]
    func fetchPokemonDetails(url:String) async throws -> PokemonDetails
}
