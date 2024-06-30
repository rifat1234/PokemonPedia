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
    enum ViewState {
        case dataLoading,dataLoaded
    }
    
    @Observable class ViewModel {
        let apiManager:APIManagerProtocol
        var searchText:String = ""
        var showAlert:Bool = false
        var alertType:AlertType = .networkError()
        var viewState:ViewState = .dataLoading
        
        private var allPokemons:[Pokemon] = []
        
        var searchedPokemons: [Pokemon] {
            if searchText.isEmpty {
                return allPokemons
            }
            
            return allPokemons.filter{$0.name.lowercased().starts(with: searchText.lowercased())}
        }
        
        
        init(apiManger:APIManagerProtocol = APIManager()){
            self.apiManager = apiManger
        }
        
        func showAlert(_ alertType: AlertType) {
            self.alertType = alertType
            showAlert = true
        }
        
        func fetchAllPokemons() async {
            do {
                self.allPokemons = try await apiManager.fetchAllPokemon().sorted{$0.name < $1.name}
                viewState = .dataLoaded
            } catch let error {
                debugPrint(error)
                showAlert(.networkError(error))
            }
        }
    }
}
