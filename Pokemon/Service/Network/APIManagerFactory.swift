//
//  APIManagerFactory.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

struct APIManagerFactory {
    static func getAPIManager() -> APIManagerProtocol {
        if CommandLine.arguments.contains(AppLaunchMode.uiTesting.rawValue) {
            let listNum: SamplePokemonList? = SamplePokemonList.allCases.filter{ CommandLine.arguments.contains($0.rawValue) }.first
            
            return MockAPIManager(listNum)
        }
        
        return APIManager()
    }
}
