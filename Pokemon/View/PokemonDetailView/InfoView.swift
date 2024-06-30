//
//  InfoView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct InfoView: View {
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

#Preview {
    InfoView(viewModel: InfoView.ViewModel( infos: [Info(name: "Rifat", url: nil),
                     Info(name: "Adnan", url: nil),
                     Info(name: "Saad", url: nil)], title: "Title"))
}
