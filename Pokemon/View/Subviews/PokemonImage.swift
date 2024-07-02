//
//  PokemonImageView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import SwiftUI
import NukeUI

/// `PokemonImage` download and caches image using NukeUI. In case, it fails, it also determine which image to show.
struct PokemonImage: View {
    private struct Const {
        static let errorImage = "questionmark.circle"
    }
    
    let url:String
    var imageLabel:String?
    
    var body: some View {
        LazyImage(
            url: URL(string: url)
        ){ state in
            if let image = state.image {
                VStack {
                    image.resizable().aspectRatio(contentMode: .fit)
                    if let imageLabel = imageLabel {
                        Text(imageLabel)
                    }
                }
            } else if state.error != nil {
                Image(systemName: Const.errorImage)
            } else {
                ProgressView()
            }
        }
    }
}
