//
//  PokemonDetailsBaseSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import SwiftUI

extension PokemonDetailsView {
    struct BasicSection: View {
        fileprivate struct Const {
            static let sectionTitle = "Basic"
            static let heightLabel = "Height"
            static let weightLabel = "Weight"
            static let baseExperienceLabel = "Base Experience"
            static let heightUnit = "dm"
            static let weightUnit = "hg"
            static let cellIconSize:CGFloat = PokemonDetailsView.Const.cellIconSize
        }
        
        let baseExperience:Int?
        let height:Int?
        let weight:Int?
        
        var body: some View {
            Section(Const.sectionTitle) {
                ListView(label: Const.heightLabel, value: height, unit: Const.heightUnit, icon: .figure)
                ListView(label: Const.weightLabel, value: weight, unit: Const.weightUnit, icon: .weight)
                ListView(label: Const.baseExperienceLabel, value: baseExperience, icon: .experience)
            }
        }
    }
    
    private struct ListView: View {
        enum Icon: String {
            case figure
            case weight = "scalemass"
            case experience = "hourglass"
        }
        
        let label: String
        let value: String?
        let unit: String
        let icon: Icon

        init(label: String, value: Int?, unit: String = "", icon: Icon = .figure) {
            self.label = label
            self.value = (value != nil) ? String(value ?? 0): nil
            self.unit = unit
            self.icon = icon
        }
        
        var body: some View {
            if let value = value {
                HStack {
                    HStack {
                        Image(systemName: icon.rawValue)
                            .frame(width: PokemonDetailsView.Const.cellIconSize)
                        Text(label)
                    }
                    Spacer()
                    Text("\(value)\(" " + unit)")
                }
            } else {
                EmptyView()
            }
        }
    }
}
