//
//  APIManager.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import Alamofire

struct APIManager: APIManagerProtocol { 
    private struct Const {
        static let allListURL = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
    }
    
    // MARK: - APIManagerProtocol
    
    /// Fetch all pokemons from server using **poke api**
    func fetchAllPokemon() async throws -> [Pokemon] {
        let response = await makeRequest(with: Const.allListURL, convertTo: Pokemons.self)
        return try response.result.get().results
    }
    
    /// Fetch all pokemon details from server using **poke api**
    /// - Parameter url: `Pokemon` detail url
    /// - Returns: `PokemonDetails` is return by **poke api** which contains all the details about the pokemon
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        let response = await makeRequest(with: url, convertTo: PokemonDetails.self)
        return try response.result.get()
    }
    
    func downloadFile(url: String, completion: ((URL?) -> ())?) {
        AF.download(url).responseURL { response in
            guard let url = try? response.result.get() else {
                completion?(nil)
                return
            }
            
            completion?(url)
        }
    }
    
    // MARK: - private methods
    
    /// Make url request using **Alamofire**. Also cache the url response.
    /// - Parameters:
    ///   - url: remote request url
    ///   - type: type of model desired from url request response
    /// - Returns: data response which could either value of `type` or  `AFError`
    private func makeRequest<T: Decodable> (with url:String, convertTo type: T.Type) async -> DataResponse<T, AFError> {
        await AF.request(url, interceptor: .retryPolicy)
            .cacheResponse(using: .cache) // Caching customization.
            .redirect(using: .follow) // Redirect customization.
            .validate() // Validate response code and Content-Type.
            .cURLDescription { description in // Produce a cURL command for the request.
                print(description)
            }
            .serializingDecodable(type.self) // Automatic Decodable support with background parsing.
            .response // Await the full response with metrics and a parsed body.
    }
}
