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
        NavigationStack {
            List{
                ForEach(viewModel.searchedPokemons){ pokemon in
                    ZStack {
                        Button(""){}
                        NavigationLink(value: pokemon) {
                            PokemonCellView(pokemon: pokemon)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Text("Search"))
            .navigationTitle(Text("Pokemon"))
            .navigationDestination(for: Pokemon.self){ pokemon in
                PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(pokemon))
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
