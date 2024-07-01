//
//  PokemonView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI

extension PokemonListView {
    struct PokemonCellView: View {
        struct Const {
            static let pokemonImageSize:CGFloat = 30
        }
        
        let pokemon: Pokemon
        var body: some View {
            HStack{
                PokemonImage(url: pokemon.imageURL)
                    .frame(width:Const.pokemonImageSize, height:Const.pokemonImageSize)
                Text(pokemon.name)
            }
        }
    }
}

