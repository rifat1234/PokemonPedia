//
//  AppearanceSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    struct AppearanceSection: View {
        let pokemonDetails:PokemonDetails
        
        var body: some View {
            if let sprites = pokemonDetails.sprites,
               let front = sprites.frontDefault {
                Section("Appearance") {
                    HStack(alignment: .center) {
                        Spacer()
                        PokemonAppearance(url: front, label: "Front")
                        if let back = sprites.backDefault {
                            Spacer()
                            PokemonAppearance(url: back, label: "Back")
                        }
                        Spacer()
                    }
                    .frame(height: 100)
                }
            }
        }
    }
    
    private struct PokemonAppearance: View {
        let url: String
        let label: String
        
        var body: some View {
            VStack {
                PokemonImage(url: url)
                Text(label)
                    .font(.callout)
            }
        }
    }
}
