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
            static let latestImage = "speaker.wave.3"
            static let legacyImage = "speaker.wave.3"
            static let playButtonImage = "play"
            static let playButtonSize:CGFloat = 40
            static let iconImageSize:CGFloat = PokemonDetailsView.Const.cellIconSize
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
        var imageName:String {
            type == .latest ? CriesSection.Const.latestImage: CriesSection.Const.legacyImage
        }
        
        var body: some View {
            if (type == .latest ? viewModel.latestCry: viewModel.legacyCry) != nil {
                HStack {
                    Image(systemName: imageName)
                        .frame(width: CriesSection.Const.iconImageSize)
                    Text(label)
                    Spacer()
                    Button {
                        viewModel.playCries(type)
                    } label: {
                        switch viewModel.criesState {
                        case .play:
                            Image(systemName: CriesSection.Const.playButtonImage)
                                .frame(width: CriesSection.Const.playButtonSize)
                        case .processing:
                            ProgressView()
                                .controlSize(.small)
                        }
                        
                    }
                }
            }
        }
        
        
    }
}
