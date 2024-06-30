//
//  PokemonDetailsBaseSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import SwiftUI

extension PokemonDetailsView {
    struct BasicSection: View {
        let pokemonDetails: PokemonDetails
        
        var body: some View {
            Section {
                ListView(label: "Base Experience", value: pokemonDetails.baseExperience)
                ListView(label: "Height", value: pokemonDetails.height)
                ListView(label: "Weight", value: pokemonDetails.weight)
            }
        }
    }
    
    private struct ListView: View {
        let label: String
        let value: String?

        init(label: String, value: Int?) {
            self.label = label
            self.value = (value != nil) ? String(value!): nil
        }
        
        var body: some View {
            if let value = value {
                HStack {
                    Text(label)
                        .font(.headline)
                    Spacer()
                    Text(value)
                        .font(.title3)
                }
            } else {
                EmptyView()
            }
        }
    }
}
