//
//  FetchPokemonListUseCase.swift
//  Pokemon
//
//  Created by Rifat Monzur on 25/9/24.
//

public protocol FetchPokemonListUseCaseDef {
    func execute(searchTerm: String?) async throws -> [Pokemon]
}

public class FetchPokemonListUseCase: FetchPokemonListUseCaseDef {
    private let repository: PokemonRepository
    private var cachedPokemons:[Pokemon]? = nil

    public init(repository: PokemonRepository) {
        self.repository = repository
    }

    /// In case of empty `searchTerm` return all pokemons else return all the pokemon starts with `searchTerm`
    public func execute(searchTerm: String? = nil) async throws -> [Pokemon] {
        if let cachedPokemons = cachedPokemons {
            return filterPokemons(cachedPokemons, with: searchTerm)
        }
        
        let allPokemons = try await repository.fetchAllPokemon()
        cachedPokemons = allPokemons
        return filterPokemons(allPokemons, with: searchTerm)
        
    }
    
    private func filterPokemons(_ allPokemons: [Pokemon], with searchTerm: String? = nil) -> [Pokemon] {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            return allPokemons.sorted{$0.name < $1.name}
        }

        return allPokemons.filter{$0.name.lowercased().starts(with: searchTerm.lowercased())}.sorted{$0.name < $1.name}
    }
}

