//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI

struct PokemonListView: View {
    @Bindable var viewModel:ViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List{
                ForEach(viewModel.searchedPokemons){ pokemon in
                    NavigationLink(value: pokemon) {
                        PokemonCellView(pokemon: pokemon)
                    }
                    
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Text("Search by name"))
            .navigationTitle("Pokemon")
            .navigationDestination(for: Pokemon.self){ pokemon in
                Text(pokemon.name)
            }
            .task {
                await viewModel.fetchAllPokemons()
            }
        }
    }
}

#Preview {
    PokemonListView(viewModel: PokemonListView.ViewModel())
}
