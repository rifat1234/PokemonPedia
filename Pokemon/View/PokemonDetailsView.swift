//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct ListView: View {
    let label: String
    let value: String
    var body: some View {
        VStack(alignment:.leading) {
            Text(label)
                .font(.subheadline)
            Text(value)
                .font(.title)
        }
    }
    
    
}

struct PokemonDetailsView: View {
    var body: some View {
        List {
            Section {
                ListView(label: "Base Experience", value: String(42))
                ListView(label: "Height", value: String(50))
                ListView(label: "Weight", value: String(3))
            }
        }
        .navigationTitle("Pokemon")
    }
}

#Preview {
    PokemonDetailsView()
}
