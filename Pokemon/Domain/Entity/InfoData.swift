//
//  InfoData.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation

/// `InfoData` model is used by `InfoView` to show data
/// Since many `PokemonDetails` contains similar type of data containing `Info` array, we can reuse  `InfoView`,  to show them all using `InfoData`
public struct InfoData: Hashable {
    /// `DataType` address which type of `Infos` array it has.
    public enum DataType: Hashable {
        case abilities
        case moves
        case heldItems
        case forms
        case types
        case gameIndices

        public var title:String {
            switch self {
            case .abilities:
                "Abilities"
            case .moves:
                "Moves"
            case .heldItems:
                "Held Items"
            case .forms:
                "Forms"
            case .types:
                "Types"
            case .gameIndices:
                "Game Indices"
            }
        }
    }
    
    public let type:DataType
    public let infos:[Info]
    public var title:String {
        type.title
    }
}
