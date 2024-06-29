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
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        let response = await makeRequest(with: Const.allListURL, convertTo: Pokemons.self)
        return try response.result.get().results
    }
    
    private func makeRequest<T: Decodable> (with url:String, convertTo type: T.Type) async -> DataResponse<T, AFError> {
        await AF.request(url, interceptor: .retryPolicy)
        // Caching customization.
            .cacheResponse(using: .cache)
        // Redirect customization.
            .redirect(using: .follow)
        // Validate response code and Content-Type.
            .validate()
        // Produce a cURL command for the request.
            .cURLDescription { description in
                print(description)
            }
        // Automatic Decodable support with background parsing.
            .serializingDecodable(type.self)
        // Await the full response with metrics and a parsed body.
            .response
    }
    
}
