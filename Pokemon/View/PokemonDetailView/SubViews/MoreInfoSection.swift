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
        private struct Const {
            static let sectionTitle = "More"
            static let abilitiesLabel = "Abilities"
            static let movesLabel = "Moves"
            static let heldItemLabel = "Held Items"
            static let formsLabel = "Forms"
            static let typesLabel = "Types"
            static let gameIndicesLabel = "Game Indices"
        }
        
        let abilities:[Ability]?
        let moves:[Move]?
        let heldItems:[HeldItem]?
        let forms:[Info]?
        let types:[TypeElement]?
        let gameIndices:[GameIndex]?
        
        var body: some View {
            Section(Const.sectionTitle) {
                MoreInfoCell(label:Const.abilitiesLabel, items: abilities, icon: .ability)
                MoreInfoCell(label:Const.movesLabel, items: moves, icon: .moves)
                MoreInfoCell(label:Const.heldItemLabel, items: heldItems, icon: .heldItems)
                MoreInfoCell(label:Const.formsLabel, items: forms, icon: .forms)
                MoreInfoCell(label:Const.typesLabel, items: types, icon: .types)
                MoreInfoCell(label:Const.gameIndicesLabel, items: gameIndices, icon: .game)
            }
        }
    }
    
    private struct MoreInfoCell<T>: View where T:Hashable  {
        enum Icon: String {
            case ability = "figure.climbing"
            case moves = "figure.gymnastics"
            case heldItems = "figure.hunting"
            case forms = "figure.stand.line.dotted.figure.stand"
            case types = "figure.run.square.stack.fill"
            case game = "gamecontroller"
        }
        
        let label:String
        let items:[T]?
        let icon:Icon
        
        var body: some View {
            if let items = items, items.count > 0 {
                NavigationLink(value: items) {
                    HStack {
                        Image(systemName: icon.rawValue)
                            .frame(width:20)
                        Text(label)
                    }
                    
                }
            } else {
                EmptyView()
            }
        }
    }
}
