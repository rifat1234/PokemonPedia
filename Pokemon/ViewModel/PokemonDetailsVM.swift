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
        
        init(_ pokemon: Pokemon, apiManager: APIManagerProtocol = APIManager()) {
            self.apiManager = apiManager
            self.pokemon = pokemon
        }
        
        func getMoreInfoData()->[InfoData]{
            func getInfoData(type:InfoData.DataType, infos:[Info]?)->InfoData? {
                guard let infos = infos else {
                    return nil
                }
                
                return InfoData(type: type, infos: infos)
            }
            
            return [
                getInfoData(type:.abilities, infos: pokemonDetails?.abilities?.compactMap({ $0.ability })),
                getInfoData(type:.moves, infos: pokemonDetails?.moves?.compactMap({ $0.move })),
                getInfoData(type:.heldItems, infos: pokemonDetails?.heldItems?.compactMap({ $0.item })),
                getInfoData(type:.forms, infos: pokemonDetails?.forms?.compactMap({ $0 })),
                getInfoData(type:.types, infos: pokemonDetails?.types?.compactMap({ $0.type })),
                getInfoData(type:.gameIndices, infos: pokemonDetails?.gameIndices?.compactMap({ $0.version })),
            ].compactMap({$0}).filter({$0.infos.count > 0})
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

