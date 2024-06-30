//
//  MoreInfoSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import SwiftUI

extension PokemonDetailsView {
    struct MoreInfoSection: View {
        let abilities:[Ability]?
        let moves:[Move]?
        let heldItems:[HeldItem]?
        let forms:[Info]?
        let types:[TypeElement]?
        let gameIndices:[GameIndex]?
        
        var body: some View {
            Section("More Infos") {
                MoreInfoCell(label:"Abilities", items: abilities)
                MoreInfoCell(label:"Moves", items: moves)
                MoreInfoCell(label:"Held Items", items: heldItems)
                MoreInfoCell(label:"Forms", items: forms)
                MoreInfoCell(label:"Types", items: types)
                MoreInfoCell(label:"Game Indices", items: gameIndices)
            }
        }
    }
    
    private struct MoreInfoCell<T>: View where T:Hashable  {
        let label:String
        let items:[T]?
        var body: some View {
            if let items = items, items.count > 0 {
                NavigationLink(value: items) {
                    Text(label)
                }
            } else {
                EmptyView()
            }
        }
    }
}
