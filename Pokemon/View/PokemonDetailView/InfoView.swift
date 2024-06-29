//
//  InfoView.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

struct InfoView: View {
    let infos:[Info]
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

#Preview {
    InfoView(infos: [Info(name: "Rifat", url: nil),
                     Info(name: "Adnan", url: nil),
                     Info(name: "Saad", url: nil)], title: "Title")
}
