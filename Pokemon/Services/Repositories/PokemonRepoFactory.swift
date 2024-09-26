//
//  APIManagerFactory.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

import PokemonCore

struct PokemonRepoFactory {
    static func create() -> PokemonRepository {
        if CommandLine.arguments.contains(AppLaunchMode.uiTesting.rawValue) {
            let listNum: SamplePokemonList? = SamplePokemonList.allCases.filter{ CommandLine.arguments.contains($0.rawValue) }.first
            
            return MockPokemonRepo(listNum)
        }
        
        return RemotePokemonRepo()
    }
}
