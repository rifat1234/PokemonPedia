//
//  FetchPokemonDetailsUseCase.swift
//  Pokemon
//
//  Created by Rifat Monzur on 26/9/24.
//

public protocol FetchPokemonDetailsUseCaseDef {
    func execute(pokemon: Pokemon) async throws -> PokemonDetails
}

public class FetchPokemonDetailsUseCase: FetchPokemonDetailsUseCaseDef {
    private let repository: PokemonRepository

    public init(repository: PokemonRepository) {
        self.repository = repository
    }

    public func execute(pokemon: Pokemon) async throws -> PokemonDetails {
        return try await repository.fetchPokemonDetails(url: pokemon.url)
    }
}
