//
//  APIManagerFactory.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

struct APIManagerFactory {
    static func getAPIManager() -> APIManagerProtocol {
        if CommandLine.arguments.contains("Testing") {
            return MockAPIManager(allPokemon: SamplePokemonList.list1)
        }
        
        return APIManager()
    }
}
