//
//  PokemonDetailsVM.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI
import Observation

extension PokemonDetailsView {
    @Observable class ViewModel {
        private let apiManager: APIManagerProtocol
        let pokemon: Pokemon
        var navigationPath = NavigationPath()
        var pokemonDetails: PokemonDetails?
        
        init(_ pokemon: Pokemon, apiManager: APIManagerProtocol = APIManager()) {
            self.apiManager = apiManager
            self.pokemon = pokemon
        }
        
        func fetchPokemonDetails() async {
            do {
                self.pokemonDetails = try await self.apiManager.fetchPokemonDetails(url: pokemon.url)
            } catch {
                debugPrint(error)
            }
        }
    }
}

