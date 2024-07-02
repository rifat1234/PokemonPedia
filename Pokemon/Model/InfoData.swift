//
//  InfoData.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation

struct InfoData: Hashable {
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
