//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation

struct PokemonDetails:Codable, Equatable {
    let id:Int?
    let name:String
    let baseExperience:Int?
    let height:Int?
    let weight:Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight
        case baseExperience = "base_experience"
    }
}
