//
//  AppearanceSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    struct AppearanceSection: View {
        fileprivate struct Const {
            static let sectionTitle = "Appearance"
            static let pokemonFrontLabel = "Front"
            static let pokemonBackLabel = "Back"
            static let imageSectionSize:CGFloat = 100
            static let shinyToggleButtonText = "Shiny"
            static let shinyToggleIcon = "wand.and.stars.inverse"
        }
        
        let front:String?
        let back:String?
        let frontShiny:String?
        let backShiny:String?
        @State private var showShiny = false
        
        var body: some View {
            if let front = front {
                let shinyURLs = [frontShiny, backShiny].compactMap{$0}
                
                Section(Const.sectionTitle) {
                    HStack {
                        Spacer()
                        PokemonAppearance(url: showShiny ? (frontShiny ?? "") : front, label: Const.pokemonFrontLabel)
                        if let back = back {
                            Spacer()
                            PokemonAppearance(url: showShiny ? (backShiny ?? "") : back, label: Const.pokemonBackLabel)
                        }
                        Spacer()
                    }
                    .frame(height: Const.imageSectionSize)
                    
                    if shinyURLs.count > 0 {
                        HStack {
                            Image(systemName: Const.shinyToggleIcon)
                                .frame(width: 20)
                            Toggle(Const.shinyToggleButtonText, isOn: $showShiny)
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
                    .frame(width: AppearanceSection.Const.imageSectionSize)
                    
            }
        }
    }
    
}
