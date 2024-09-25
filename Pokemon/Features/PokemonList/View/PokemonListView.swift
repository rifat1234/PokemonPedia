//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI

/// Show list of `Pokemon` model containing name and image with option to show more details about the pokemon
struct PokemonListView: View {
    struct Const {
        static let navigationTitle = Text("Pokemon")
        static let searchBarPrompt = Text("Search")
        static let pokemonListAccessibilityID = "PokemonListAccessibilityID"
    }
    
    @Bindable var viewModel:ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .dataLoading:
                    ProgressView()
                        .controlSize(.extraLarge)
                case .dataLoaded:
                    List {
                        ForEach(viewModel.searchedPokemons){ pokemon in
                            ZStack {
                                Button(""){} // TODO: Find better solution to deselect selected cell
                                NavigationLink(value: pokemon) {
                                    PokemonCellView(pokemon: pokemon)
                                }
                            }
                        }
                    }
                    .accessibilityIdentifier(Const.pokemonListAccessibilityID)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Const.searchBarPrompt)
            .navigationTitle(Const.navigationTitle)
            .navigationDestination(for: Pokemon.self){ pokemon in
                PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(pokemon))
            }
            .alertify(viewModel)
            .task(id: viewModel.searchText, {
                await viewModel.fetchAllPokemons()
            })
        }
    }
}

#Preview {
    PokemonListView(viewModel: PokemonListView.ViewModel())
}
