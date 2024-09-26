//
//  PokemonDetailsVM.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI
import Observation
import PokemonCore

extension PokemonDetailsView {
    /// Help `PokemonDetailsView` to determine which view to show
    enum ViewState {
        case dataLoading, dataLoaded
    }
    
    enum CriesType {
        case latest,legacy
    }
    
    enum CriesState {
        case play, processing
    }
    
    @Observable 
    class ViewModel: AlertHandler {
        //MARK: - public variables
        var viewState: ViewState = .dataLoading
        var criesState: CriesState = .play
        var dismissView: Bool = false
        
        //MARK: - private variables
        private let pokemon: Pokemon
        private var pokemonDetails: PokemonDetails?
        private let fetchPokemonDetailsUseCase: FetchPokemonDetailsUseCaseDef
        private let fileDownloader: FileDownloaderDef
        private let audioPlayer: AudioPlayerDef
        private let oggToWavConverter: OGGToWavConverterDef
        
        //MARK: - computed variables
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
        
        var latestCry: String? {
            pokemonDetails?.cries?.latest
        }
        
        var legacyCry: String? {
            pokemonDetails?.cries?.legacy
        }
        
        //MARK: - init
        init(_ pokemon: Pokemon,
             fetchPokemonDetailsUseCase: FetchPokemonDetailsUseCase = FetchPokemonDetailsUseCase(repository: PokemonRepoFactory.getAPIManager()),
             fileDownloader: FileDownloaderDef = FileDownloader(),
             audioPlayer: AudioPlayerDef = AudioPlayer(),
             oggToWavConverter: OGGToWavConverterDef = OGGToWavConverter()) {
            self.pokemon = pokemon
            self.fetchPokemonDetailsUseCase = fetchPokemonDetailsUseCase
            self.fileDownloader = fileDownloader
            self.audioPlayer = audioPlayer
            self.oggToWavConverter = oggToWavConverter
        }
        
        //MARK: - public methods
        
        /// Process models which are beyond the scope of `PhotoDetailsView` and require seperate `InfoDataView`
        /// - Important: All those models process can tranform into `InfoData`
        /// - Returns: list of non-empty `InfoData`
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
        
        /// fetch pokemon details from the server
        func fetchPokemonDetails() async {
            do {
                self.pokemonDetails = try await self.fetchPokemonDetailsUseCase.execute(pokemon: pokemon)
                viewState = .dataLoaded
            } catch {
                debugPrint(error)
                showAlert(.pokemonDetailNetworkError(error))
            }
        }
        
        
        // TODO: Convert to Swift Concurrency
        /// download ogg format audio, then convert it to wav and  play audio
        /// - Parameter type: which type of cries to play latest or legacy
        func playCries(_ type: CriesType) {
            guard let cryURL = type == .latest ? latestCry: legacyCry else {
                return
            }
            
            criesState = .processing
            
            fileDownloader.downloadFile(url: cryURL) { [weak self] url in
                guard let fileURL = url else {
                    debugPrint("Download failed")
                    self?.showAlert(.audioNetworkError)
                    self?.criesState = .play
                    return
                }
                
                guard let wavURL = self?.oggToWavConverter.convert(fileURL) else {
                    debugPrint("Convert to wav failed")
                    self?.showAlert(.audioPlayingError)
                    self?.criesState = .play
                    return
                }
                
                do {
                    try self?.audioPlayer.play(url: wavURL)
                } catch {
                    debugPrint(error)
                    self?.showAlert(.audioPlayingError)
                }
                
                self?.criesState = .play
            }
        }
        
        
        // MARK: - AlertHandler
        var alertType: AlertType = .pokemonDetailNetworkError()
        var showAlert: Bool = false
        
        func showAlert(_ alertType: AlertType) {
            self.alertType = alertType
            showAlert = true
        }
        
        func alertPrimaryButtonAction(_ alertType: AlertType) async {
            switch alertType {
            case .pokemonDetailNetworkError:
                await fetchPokemonDetails()
            default:
                break
            }
        }
        
        func alertSecondaryButtonAction(_ alertType: AlertType) async {
            switch alertType {
            case .pokemonDetailNetworkError:
                dismissView = true
            default:
                break
            }
        }
    }
}

