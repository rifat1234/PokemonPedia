//
//  CriesSection.swift
//  Pokemon
//
//  Created by Rifat on 03/07/2024.
//

import SwiftUI

extension PokemonDetailsView {
    struct CriesSection: View {
        fileprivate struct Const {
            static let sectionTitle = "Cries"
            static let latestLabel = "Latest"
            static let legacyLabel = "Legacy"
            static let playButtonImage = "play"
            static let playButtonSize:CGFloat = 40
        }
        
        let viewModel:ViewModel
        var body: some View {
            if ![viewModel.latestCry, viewModel.legacyCry].compactMap({$0}).isEmpty {
                Section(Const.sectionTitle) {
                    CriesCellView(type: .latest, viewModel: viewModel)
                    CriesCellView(type: .legacy, viewModel: viewModel)
                }
            }
        }
    }
    
    private struct CriesCellView: View {
        let type: CriesType
        let viewModel: ViewModel
        var label:String {
            type == .latest ? CriesSection.Const.latestLabel: CriesSection.Const.legacyLabel
        }
        
        var body: some View {
            if (type == .latest ? viewModel.latestCry: viewModel.legacyCry) != nil {
                HStack {
                    Text(label)
                    Spacer()
                    Button {
                        viewModel.playCries(type)
                    } label: {
                        Image(systemName: CriesSection.Const.playButtonImage)
                            .frame(width: CriesSection.Const.playButtonSize)
                    }
                }
            }
        }
        
        
    }
}
