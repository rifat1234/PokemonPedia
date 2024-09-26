//
//  DownloadFileUseCase.swift
//  Pokemon
//
//  Created by Rifat Monzur on 26/9/24.
//

import Foundation

public class DownloadFileUseCase {
    private let repository: PokemonRepository

    public init(repository: PokemonRepository) {
        self.repository = repository
    }

    public func execute(url: String, completion: ((URL?) -> ())?) {
        return repository.downloadFile(url: url, completion: completion)
    }
}
