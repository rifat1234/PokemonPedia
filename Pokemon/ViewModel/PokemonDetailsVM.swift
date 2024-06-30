//
//  PokemonDetailsVM.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI
import Observation

extension PokemonDetailsView {
    enum ViewState {
        case dataLoading, dataLoaded
    }
    @Observable class ViewModel: AlertHandler {
        var alertType: AlertType = .networkError()
        var showAlert: Bool = false
        var viewState: ViewState = .dataLoading
        
        private let apiManager: APIManagerProtocol
        private let pokemon: Pokemon
        private var pokemonDetails: PokemonDetails?
        
        var navigationTitle: String {
            pokemon.name
        }
        
        var defaultFrontSprite: String? {
            pokemonDetails?.sprites?.frontDefault
        }
        
        var defaultBackSprite: String? {
            pokemonDetails?.sprites?.backDefault
        }
        
        var defaultShinyFrontSprite: String? {
            pokemonDetails?.sprites?.frontShiny
        }
        
        var defaultShinyBackSprite: String? {
            pokemonDetails?.sprites?.backShiny
        }
        
        var baseExperience: Int? {
            pokemonDetails?.baseExperience
        }
        
        var height: Int? {
            pokemonDetails?.height
        }
        
        var weight: Int? {
            pokemonDetails?.weight
        }
        
        var stats: [Stat]? {
            pokemonDetails?.stats
        }
        
        var abilities: [Ability]? {
            pokemonDetails?.abilities
        }
        
        var moves: [Move]? {
            pokemonDetails?.moves
        }
        
        var heldItems: [HeldItem]? {
            pokemonDetails?.heldItems
        }
        
        var forms: [Info]? {
            pokemonDetails?.forms
        }
        
        var types: [TypeElement]? {
            pokemonDetails?.types
        }
        
        var gameIndices: [GameIndex]? {
            pokemonDetails?.gameIndices
        }
        
        init(_ pokemon: Pokemon, apiManager: APIManagerProtocol = APIManager()) {
            self.apiManager = apiManager
            self.pokemon = pokemon
        }
        
        func showAlert(_ alertType: AlertType) {
            self.alertType = alertType
            showAlert = true
        }
        
        func fetchPokemonDetails() async {
            do {
                self.pokemonDetails = try await self.apiManager.fetchPokemonDetails(url: pokemon.url)
                viewState = .dataLoaded
            } catch {
                debugPrint(error)
                showAlert(.networkError(error))
            }
        }
    }
}

