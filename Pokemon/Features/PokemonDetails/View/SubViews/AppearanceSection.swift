//
//  AppearanceSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    /// show pokemon images of both front and back with shiny option (depends on availability)
    struct AppearanceSection: View {
        fileprivate struct Const {
            static let sectionTitle = "Appearance"
            static let pokemonFrontLabel = "Front"
            static let pokemonBackLabel = "Back"
            static let imageSectionSize:CGFloat = 100
            static let shinyToggleIconSize:CGFloat = PokemonDetailsView.Const.cellIconSize
            static let shinyToggleButtonText = "Shiny"
            static let shinyToggleIcon = "wand.and.stars.inverse"
        }
        
        let front:String?
        let back:String?
        let frontShiny:String?
        let backShiny:String?
        @State private var showShiny = false
        
        var body: some View {
            if let front = front { // Only show image if front default image available
                let shinyURLs = [frontShiny, backShiny].compactMap{$0}
                
                Section(Const.sectionTitle) {
                    HStack { // Shows front and back image
                        Spacer()
                        PokemonAppearance(url: showShiny ? (frontShiny ?? "") : front, label: Const.pokemonFrontLabel)
                        if let back = back { // Check if back image available
                            Spacer()
                            PokemonAppearance(url: showShiny ? (backShiny ?? "") : back, label: Const.pokemonBackLabel)
                        }
                        Spacer()
                    }
                    .frame(height: Const.imageSectionSize)
                    .alignmentGuide(.listRowSeparatorLeading, computeValue: { dimension in
                        return 0
                    })
                    
                    if shinyURLs.count > 0 { // show toggle button only if shiny image available
                        HStack {
                            Image(systemName: Const.shinyToggleIcon)
                                .frame(width: Const.shinyToggleIconSize)
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
