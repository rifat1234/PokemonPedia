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
            Section("More") {
                MoreInfoCell(label:"Abilities", items: abilities, icon: .ability)
                MoreInfoCell(label:"Moves", items: moves, icon: .moves)
                MoreInfoCell(label:"Held Items", items: heldItems, icon: .heldItems)
                MoreInfoCell(label:"Forms", items: forms, icon: .forms)
                MoreInfoCell(label:"Types", items: types, icon: .types)
                MoreInfoCell(label:"Game Indices", items: gameIndices, icon: .game)
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
