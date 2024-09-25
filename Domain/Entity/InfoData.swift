//
//  InfoData.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation

/// `InfoData` model is used by `InfoView` to show data
/// Since many `PokemonDetails` contains similar type of data containing `Info` array, we can reuse  `InfoView`,  to show them all using `InfoData`
struct InfoData: Hashable {
    /// `DataType` address which type of `Infos` array it has.
    enum DataType: Hashable {
        case abilities
        case moves
        case heldItems
        case forms
        case types
        case gameIndices

        var title:String {
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
    
    let type:DataType
    let infos:[Info]
    var title:String {
        type.title
    }
}
