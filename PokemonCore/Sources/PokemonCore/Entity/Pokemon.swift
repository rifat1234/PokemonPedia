//
//  Pokemon.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation

/// `Pokemon` model contains pokemon name, detail's url and imageURL
/// It can be used to show basic info of pokemon with image
public struct Pokemon: Codable, Equatable, Hashable, Identifiable {
    public let name:String
    public let url:String
    public let imageURL:String
    
    public var id: String {
        name
    }
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
        self.imageURL = Pokemon.getImageURL(from: url)
    }
    
    /// During decoding we are changing `name` format from lower case to **capitalized** and also  replacing **'-'** with **single space**
    /// Example: from "aggron-mega" to "Aggron Mega"
    /// - Parameter decoder: decoder is used to decode from json to struct values
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name).capitalized.replacingOccurrences(of: "-", with: " ")
        self.url = try container.decode(String.self, forKey: .url)
        self.imageURL = Pokemon.getImageURL(from: url)
    }
    
    /// Since image url of pokemon is not provided, we are making them from pokemon url.
    /// - Parameter url: url of pokemon details
    /// - Returns: pokemon image remote url
    private static func getImageURL(from url:String)-> String {
        let strings =  url.split(separator: "/")
        let num = strings[strings.count - 1] // extract only the last part or pokemon name
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(num).png"
    }
}
