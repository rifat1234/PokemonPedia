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
                    MoreInfoSection(infoDatas: viewModel.getMoreInfoData())
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
        .navigationDestination(for: InfoData.self) { infoData in
            InfoView(viewModel: InfoView.ViewModel(infoData: infoData))
        }
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
