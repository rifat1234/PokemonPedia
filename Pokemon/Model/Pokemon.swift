//
//  Pokemon.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name:String
    let url:String
    let imageURL:String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
        
        let strings =  url.split(separator: "/")
        let num = strings[strings.count - 1]
        self.imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(num).png"
    }
}
