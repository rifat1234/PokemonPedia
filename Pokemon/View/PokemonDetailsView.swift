//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct InfoView: View {
    let infos:[Species]
    let title:String
    var body: some View {
        List {
            ForEach(infos, id: \.self) { info in
                Text(info.name ?? "")
            }
        }
        .navigationTitle(title)
    }
}

struct MoreInfoCell<T>: View where T:Hashable  {
    let label:String
    let items:[T]?
    var body: some View {
        if let items = items, items.count > 0 {
            NavigationLink(value: items) {
                Text(label)
            }
        } else {
            EmptyView()
        }
    }
}

struct PokemonDetailsView: View {
    @Bindable var viewModel:ViewModel
    
    var body: some View {
        VStack{
            if let pokemonDetails = viewModel.pokemonDetails{
                List {
                    BasicSection(pokemonDetails: pokemonDetails)
                    Section {
                        MoreInfoCell(label:"Moves", items: pokemonDetails.moves)
                        MoreInfoCell(label:"Forms", items: pokemonDetails.forms)
                        MoreInfoCell(label:"Held Items", items: pokemonDetails.heldItems)
                        MoreInfoCell(label:"Abilities", items: pokemonDetails.abilities)
                    }
                    
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.pokemon.name)
        .navigationDestination(for: [Move].self) { moves in
            InfoView(infos:moves.compactMap{$0.move} , title: "Moves")
        }
        .navigationDestination(for: [Species].self) { forms in
            InfoView(infos:forms , title: "Forms")
        }
        .navigationDestination(for: [HeldItem].self) { heldItems in
            InfoView(infos:heldItems.compactMap{$0.item} , title: "Held Items")
        }
        .navigationDestination(for: [Ability].self) { abilities in
            InfoView(infos:abilities.compactMap{$0.ability} , title: "Abilities")
        }
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
