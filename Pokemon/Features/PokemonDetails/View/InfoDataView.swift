//
//  InfoView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI
import PokemonCore

/// Simple view which show title and list of names 
struct InfoDataView: View {
    @Bindable var viewModel:ViewModel
    var body: some View {
        List {
            ForEach(viewModel.sortedInfo, id: \.self) { info in
                Text(info.name ?? "")
            }
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

//#Preview {
//    InfoDataView(viewModel: InfoDataView.ViewModel( infoData:InfoData(type:.forms, infos:[Info(name: "Rifat", url: nil),
//                     Info(name: "Adnan", url: nil),
//                     Info(name: "Saad", url: nil)])))
//}
