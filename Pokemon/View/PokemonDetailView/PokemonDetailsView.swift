//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

/// Show details of a Pokemon with an option to show even more information about the pokemon
struct PokemonDetailsView: View {
    struct Const {
        static let cellIconSize:CGFloat = 20
    }
    
    @Bindable var viewModel:ViewModel
    @Environment(\.dismiss) var dismiss // used to dismiss current view from navigation stack
    
    var body: some View {
        VStack{
            switch viewModel.viewState {
            case .dataLoading:
                ProgressView()
                    .controlSize(.large)
                
            case .dataLoaded:
                List {
                    // show pokemon images of both front and back with shiny option (depends on availability)
                    AppearanceSection(front: viewModel.defaultFrontSprite,
                                      back: viewModel.defaultBackSprite,
                                      frontShiny: viewModel.defaultShinyFrontSprite,
                                      backShiny: viewModel.defaultShinyBackSprite)
                    // show basic details like base experience, height and weight
                    BasicSection(baseExperience: viewModel.baseExperience,
                                 height: viewModel.height,
                                 weight: viewModel.weight)
                    // show pokemon stats like attack, defence, hit point and so on.
                    StatsSection(stats: viewModel.stats)
                    // give user option to know about pokemon features like ability, moves, held items and so on
                    MoreInfoSection(infoDatas: viewModel.getMoreInfoData())
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertType.title),
                message: Text(viewModel.alertType.message),
                primaryButton:.default(Text(viewModel.alertType.primaryButtonText)){
                    Task {
                        await viewModel.alertPrimaryButtonAction(viewModel.alertType)
                    }
                },
                  secondaryButton: .destructive(Text(viewModel.alertType.secondaryButtonText), action: {
                    dismiss()
                })
            )
        })
        .navigationTitle(viewModel.navigationTitle)
        .navigationDestination(for: InfoData.self) { infoData in // Navigation from MoreInfoSection
            InfoDataView(viewModel: InfoDataView.ViewModel(infoData: infoData))
        }
        .task {
            await viewModel.fetchPokemonDetails() // start fetching pokemon details after view appears
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
