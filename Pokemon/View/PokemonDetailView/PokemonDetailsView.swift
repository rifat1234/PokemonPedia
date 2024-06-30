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
            if let pokemonDetails = viewModel.pokemonDetails {
                List {
                    if let sprites = pokemonDetails.sprites {
                        Section("Appearance") {
                            HStack(alignment: .center) {
                                if let front = sprites.frontDefault {
                                    PokemonImage(url: front)
                                        .frame(height: 90)
                                }
                                
                                
                                
                                if let back = sprites.backDefault {
                                    Spacer()
                                    PokemonImage(url: back)
                                        .frame(height: 90)
                                }
                            }
                        }
                    }
                    BasicSection(pokemonDetails: pokemonDetails)
                    StatsSection(pokemonDetails: pokemonDetails)
                    MoreInfoSection(pokemonDetails: pokemonDetails)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.pokemon.name)
        .navigationDestination(for: [Move].self) { moves in
            InfoView(infos:moves.compactMap{$0.move} , title: "Moves")
        }
        .navigationDestination(for: [Info].self) { forms in
            InfoView(infos:forms , title: "Forms")
        }
        .navigationDestination(for: [HeldItem].self) { heldItems in
            InfoView(infos:heldItems.compactMap{$0.item} , title: "Held Items")
        }
        .navigationDestination(for: [Ability].self) { abilities in
            InfoView(infos:abilities.compactMap{$0.ability} , title: "Abilities")
        }
        .navigationDestination(for: [TypeElement].self) { types in
            InfoView(infos:types.compactMap{$0.type} , title: "Types")
        }
        .navigationDestination(for: [GameIndex].self) { gameIndices in
            InfoView(infos:gameIndices.compactMap{$0.version} , title: "Game Indices")
        }
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
