//
//  MoreInfoSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import SwiftUI

extension PokemonDetailsView {
    struct MoreInfoSection: View {
        fileprivate struct Const {
            static let sectionTitle = "More"
            static let moreInfoIconSize:CGFloat = PokemonDetailsView.Const.cellIconSize
        }
        
        let infoDatas:[InfoData]
        
        var body: some View {
            Section(Const.sectionTitle) {
                ForEach(infoDatas, id: \.self) { infoData in
                    MoreInfoCell(infoData: infoData)
                }
            }
        }
    }
    
    private struct MoreInfoCell: View {
        let infoData:InfoData
        
        var imageName: String {
            switch infoData.type {
            case .abilities:
                "figure.climbing"
            case .moves:
                "figure.gymnastics"
            case .heldItems:
                "figure.hunting"
            case .forms:
                "figure.stand.line.dotted.figure.stand"
            case .types:
                "figure.run.square.stack.fill"
            case .gameIndices:
                "gamecontroller"
            }
        }
        
        var body: some View {
            NavigationLink(value: infoData) {
                HStack {
                    Image(systemName: imageName)
                        .frame(width: MoreInfoSection.Const.moreInfoIconSize)
                    Text(infoData.type.title)
                }
            }
        }
    }
}
