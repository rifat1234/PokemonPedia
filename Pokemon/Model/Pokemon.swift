//
//  Pokemon.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation

struct Pokemon: Codable, Equatable, Hashable, Identifiable {
    let name:String
    let url:String
    let imageURL:String
    
    var id: String {
        name
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
        self.imageURL = Pokemon.getImageURL(from: url)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name).capitalized.replacingOccurrences(of: "-", with: " ")
        self.url = try container.decode(String.self, forKey: .url)
        self.imageURL = Pokemon.getImageURL(from: url)
    }
    
    private static func getImageURL(from url:String)-> String {
        let strings =  url.split(separator: "/")
        let num = strings[strings.count - 1]
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(num).png"
    }
}
