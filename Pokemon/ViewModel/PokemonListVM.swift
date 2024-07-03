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
    /// Help `PokemonListView` to determine which view to show
    enum ViewState {
        case dataLoading,dataLoaded
    }
    
    @Observable class ViewModel: AlertHandler {
        let apiManager:APIManagerProtocol
        var searchText:String = ""
        var viewState:ViewState = .dataLoading
        
        private var allPokemons:[Pokemon] = []
        
        /// In case of empty `searchText` return all pokemons else return all the pokemon starts with `searchText`
        var searchedPokemons: [Pokemon] {
            if searchText.isEmpty {
                return allPokemons
            }
            
            return allPokemons.filter{$0.name.lowercased().starts(with: searchText.lowercased())}
        }
        
        init(apiManger:APIManagerProtocol = APIManager()){
            self.apiManager = apiManger
        }
        
        /// Fetch all pokemons from server and sort by name in alphabatical order
        func fetchAllPokemons() async {
            do {
                self.allPokemons = try await apiManager.fetchAllPokemon().sorted{$0.name < $1.name}
                viewState = .dataLoaded
            } catch let error {
                debugPrint(error)
                showAlert(.networkError(error))
            }
        }
        
        // MARK: - AlertHandler
        var showAlert:Bool = false
        var alertType:AlertType = .networkError()
        
        func showAlert(_ alertType: AlertType) {
            self.alertType = alertType
            showAlert = true
        }
        
        func alertPrimaryButtonAction(_ alertType: AlertType) async {
            switch alertType {
            case .networkError(_):
                await fetchAllPokemons()
            default:
                break
            }
        }
    }
}
