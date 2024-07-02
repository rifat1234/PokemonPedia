//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI

/// Show list of `Pokemon` model containing name and image with option to show more details about the pokemon
struct PokemonListView: View {
    private struct Const {
        static let navigationTitle = Text("Pokemon")
        static let searchBarPrompt = Text("Search")
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
                }
            }
            .searchable(text: $viewModel.searchText, prompt: Const.searchBarPrompt)
            .navigationTitle(Const.navigationTitle)
            .navigationDestination(for: Pokemon.self){ pokemon in
                PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(pokemon))
            }
            .alert(isPresented: $viewModel.showAlert, content: { 
                Alert(title: Text(viewModel.alertType.title),
                      message: Text(viewModel.alertType.message),
                      dismissButton: .default(Text(viewModel.alertType.primaryButtonText)){
                        Task {
                            await viewModel.alertPrimaryButtonAction(viewModel.alertType)
                        }
                })
            })
            .task {
                await viewModel.fetchAllPokemons() // start fetching pokemons after view appears
            }
        }
    }
}

#Preview {
    PokemonListView(viewModel: PokemonListView.ViewModel())
}
