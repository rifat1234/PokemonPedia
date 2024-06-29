//
//  PokemonView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI
import NukeUI

extension PokemonListView {
    struct PokemonCellView: View {
        struct Const {
            static let pokemonImageSize:CGFloat = 30
        }
        
        let pokemon: Pokemon
        var body: some View {
            HStack{
                LazyImage(
                    url: URL(string: pokemon.imageURL)
                ){ state in
                    if let image = state.image {
                        image.resizable().aspectRatio(contentMode: .fit)
                    } else if state.error != nil {
                        Image(systemName: "questionmark.circle")
                            .tint(.red)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width:Const.pokemonImageSize, height:Const.pokemonImageSize)
                
                Text(pokemon.name)
                
            }
        }
    }
}

