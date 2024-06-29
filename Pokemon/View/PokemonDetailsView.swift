//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct AbilitySections: View {
    let abilities: [Ability]
    var body: some View {
        Section("Ability") {
            ForEach(abilities, id: \.ability?.name) { ability in
                Text(ability.ability?.name ?? "")
            }
        }
    }
}

struct HeldItemSections: View {
    let heldItems: [HeldItem]
    var body: some View {
        if heldItems.isEmpty {
            EmptyView()
        } else {
            Section("HeldItems") {
                ForEach(heldItems, id: \.item?.name) { heldItem in
                    Text(heldItem.item?.name ?? "")
                }
                
            }
        }
    }
}

struct MoveSection: View {
    let moves: [Move]
    var body: some View {
        if moves.isEmpty {
            EmptyView()
        } else {
            Section("Moves") {
                ForEach(moves, id: \.move?.name) { move in
                    Text(move.move?.name ?? "")
                }
            }
        }
    }
}

struct FormSection: View {
    let forms: [Species]
    var body: some View {
        if forms.isEmpty {
            EmptyView()
        } else {
            Section("Forms") {
                ForEach(forms, id: \.name) { form in
                    Text(form.name ?? "")
                }
            }
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
                    if let abilities = pokemonDetails.abilities {
                        AbilitySections(abilities: abilities)
                    }
                    
                    if let heldItems = pokemonDetails.heldItems {
                        HeldItemSections(heldItems: heldItems)
                    }
                    
                    if let moves = pokemonDetails.moves {
                        MoveSection(moves: moves)
                    }
                    
                    if let forms = pokemonDetails.forms {
                        FormSection(forms: forms)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.pokemon.name)
        .task {
            await viewModel.fetchPokemonDetails()
        }
    }
}

#Preview {
    PokemonDetailsView(viewModel: PokemonDetailsView.ViewModel(Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")))
}
