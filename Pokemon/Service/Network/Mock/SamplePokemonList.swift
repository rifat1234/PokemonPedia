//
//  SamplePokemonList.swift
//  Pokemon
//
//  Created by Rifat Monzur on 23/9/24.
//

enum SamplePokemonList: String, CaseIterable {
    case list1 = "PokemonList1"
    case list2 = "PokemonList2"
    
    var list: [Pokemon] {
        switch self {
        case .list1:
            [
                Pokemon(name: "abc", url: "url2"),
                Pokemon(name: "aab", url: "url1"),
                Pokemon(name: "pika", url: "url3")
            ]
        case .list2:
            [
                Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                Pokemon(name: "Ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
            ]
        }
    }
}
