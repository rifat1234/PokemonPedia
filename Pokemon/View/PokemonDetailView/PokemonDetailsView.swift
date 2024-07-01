//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    struct Const {
        static let cellIconSize:CGFloat = 20
    }
    
    @Bindable var viewModel:ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            switch viewModel.viewState {
            case .dataLoading:
                ProgressView()
                    .controlSize(.large)
                
            case .dataLoaded:
                List {
                    AppearanceSection(front: viewModel.defaultFrontSprite,
                                      back: viewModel.defaultBackSprite,
                                      frontShiny: viewModel.defaultShinyFrontSprite,
                                      backShiny: viewModel.defaultShinyBackSprite)
                    BasicSection(baseExperience: viewModel.baseExperience,
                                 height:viewModel.height,
                                 weight: viewModel.weight)
                    StatsSection(stats: viewModel.stats)
                    MoreInfoSection(abilities: viewModel.abilities,
                                    moves: viewModel.moves,
                                    heldItems: viewModel.heldItems,
                                    forms: viewModel.forms,
                                    types: viewModel.types,
                                    gameIndices: viewModel.gameIndices)
                    
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertType.title),
                message: Text(viewModel.alertType.message),
                primaryButton:.default(Text(viewModel.alertType.primaryButtonText)){
                    Task {
                        await viewModel.fetchPokemonDetails()
                    }
                },
                  secondaryButton: .destructive(Text(viewModel.alertType.secondaryButtonText), action: {
                    dismiss()
                })
            )
        })
        .navigationTitle(viewModel.navigationTitle)
        .navigationDestination(for: [Move].self) { moves in
            InfoView(viewModel: InfoView.ViewModel( infos:moves.compactMap{$0.move} , title: "Moves"))
        }
        .navigationDestination(for: [Info].self) { forms in
            InfoView(viewModel: InfoView.ViewModel(infos:forms , title: "Forms"))
        }
        .navigationDestination(for: [HeldItem].self) { heldItems in
            InfoView(viewModel: InfoView.ViewModel(infos:heldItems.compactMap{$0.item} , title: "Held Items"))
        }
        .navigationDestination(for: [Ability].self) { abilities in
            InfoView(viewModel: InfoView.ViewModel(infos:abilities.compactMap{$0.ability} , title: "Abilities"))
        }
        .navigationDestination(for: [TypeElement].self) { types in
            InfoView(viewModel: InfoView.ViewModel(infos:types.compactMap{$0.type} , title: "Types"))
        }
        .navigationDestination(for: [GameIndex].self) { gameIndices in
            InfoView(viewModel: InfoView.ViewModel(infos:gameIndices.compactMap{$0.version} , title: "Game Indices"))
        }
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
