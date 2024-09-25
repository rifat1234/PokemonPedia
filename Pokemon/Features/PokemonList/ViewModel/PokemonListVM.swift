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
    
    @Observable 
    class ViewModel: AlertHandler {
        var searchText:String = ""
        var viewState:ViewState = .dataLoading
        
        private let fetchPokemonListUseCase:FetchPokemonListUseCase
        
        /// In case of empty `searchText` return all pokemons else return all the pokemon starts with `searchText`
        var searchedPokemons: [Pokemon] = []
        
        init(fetchPokemonListUseCase: FetchPokemonListUseCase = FetchPokemonListUseCase(repository: APIManagerFactory.getAPIManager())){
            self.fetchPokemonListUseCase = fetchPokemonListUseCase
        }
        
        /// Fetch all pokemons from server and sort by name in alphabatical order
        func fetchAllPokemons() async {
            do {
                self.searchedPokemons = try await fetchPokemonListUseCase.execute(searchTerm: searchText)
                viewState = .dataLoaded
            } catch let error {
                debugPrint(error)
                showAlert(.pokemonListNetworkError(error))
            }
        }
        
        // MARK: - AlertHandler
        var showAlert:Bool = false
        var alertType:AlertType = .pokemonListNetworkError()
        
        func showAlert(_ alertType: AlertType) {
            self.alertType = alertType
            showAlert = true
        }
        
        func alertPrimaryButtonAction(_ alertType: AlertType) async {
            switch alertType {
            case .pokemonListNetworkError(_):
                await fetchAllPokemons()
            default:
                break
            }
        }
    }
}
