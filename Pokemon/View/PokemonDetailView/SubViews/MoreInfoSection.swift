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
        let pokemonDetails: PokemonDetails
        var body: some View {
            Section("Infos") {
                MoreInfoCell(label:"Abilities", items: pokemonDetails.abilities)
                MoreInfoCell(label:"Moves", items: pokemonDetails.moves)
                MoreInfoCell(label:"Held Items", items: pokemonDetails.heldItems)
                MoreInfoCell(label:"Forms", items: pokemonDetails.forms)
                MoreInfoCell(label:"Types", items: pokemonDetails.types)
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
