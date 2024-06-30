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
        @State private var showShiny = false
        
        var body: some View {
            if let sprites = pokemonDetails.sprites, let front = sprites.frontDefault {
                let shinyURLs = [sprites.frontShiny, sprites.backShiny].compactMap{$0}
                
                Section("Appearance") {
                    HStack {
                        Spacer()
                        PokemonAppearance(url: showShiny ? shinyURLs[0]: front, label: "Front")
                        if let back = sprites.backDefault {
                            Spacer()
                            PokemonAppearance(url: showShiny ? shinyURLs[1]: back, label: "Back")
                        }
                        Spacer()
                    }
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    
                }
                
                Section {
                    HStack {
                        if shinyURLs.count > 0 {
                            Toggle("Shiny", isOn: $showShiny)
                        }
                    }
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
