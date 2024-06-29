//
//  PokimonListViewModel.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import Foundation
import Observation
import SwiftUI

extension PokemonListView {
    @Observable class ViewModel {
        let apiManager:APIManagerProtocol
        var navigationPath = NavigationPath()
        var searchText:String = ""
        private var allPokemons:[Pokemon] = []
        
        var searchedPokemons: [Pokemon] {
            if searchText.isEmpty {
                return allPokemons
            }
            
            return allPokemons.filter{$0.name.starts(with: searchText.lowercased())}
        }
        
        
        init(apiManger:APIManagerProtocol = APIManager()){
            self.apiManager = apiManger
        }
        
        func fetchAllPokemons() async {
            do {
                self.allPokemons = try await apiManager.fetchAllPokemon()
            } catch {
                debugPrint(error)
            }
        }
    }
}
