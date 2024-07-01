//
//  AppearanceSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    struct AppearanceSection: View {
        let front:String?
        let back:String?
        let frontShiny:String?
        let backShiny:String?
        @State private var showShiny = false
        
        var body: some View {
            if let front = front {
                let shinyURLs = [frontShiny, backShiny].compactMap{$0}
                
                Section("Appearance") {
                    HStack {
                        Spacer()
                        PokemonAppearance(url: showShiny ? (frontShiny ?? "") : front, label: "Front")
                        if let back = back {
                            Spacer()
                            PokemonAppearance(url: showShiny ? (backShiny ?? "") : back, label: "Back")
                        }
                        Spacer()
                    }
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    
                    if shinyURLs.count > 0 {
                        HStack {
                            Image(systemName: "wand.and.stars.inverse")
                                .frame(width: 20)
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
                PokemonImage(url: url, imageLabel: label)
                    .foregroundColor(.gray)
                    .font(.callout)
                    .frame(width: 100)
                    
            }
        }
    }
    
}
