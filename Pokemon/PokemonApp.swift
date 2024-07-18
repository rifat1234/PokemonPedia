//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Rifat Monzur on 28/6/24.
//

import SwiftUI

@main
struct PokemonApp: App {
    @State var viewModel = PokemonListView.ViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: viewModel)
        }
    }
}
