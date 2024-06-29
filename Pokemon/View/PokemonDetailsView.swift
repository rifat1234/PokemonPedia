//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    @Bindable var viewModel:ViewModel
    
    var body: some View {
        VStack{
            if let pokemonDetails = viewModel.pokemonDetails{
                List {
                    BasicSection(pokemonDetails: pokemonDetails)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.pokemon.name)
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
