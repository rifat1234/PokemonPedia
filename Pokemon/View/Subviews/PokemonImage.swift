//
//  PokemonImageView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import SwiftUI
import NukeUI

struct PokemonImage: View {
    let url:String
    
    var body: some View {
        LazyImage(
            url: URL(string: url)
        ){ state in
            if let image = state.image {
                image.resizable().aspectRatio(contentMode: .fit)
            } else if state.error != nil {
                Image(systemName: "questionmark.circle")
                    .tint(.red)
            } else {
                ProgressView()
            }
        }
    }
}
