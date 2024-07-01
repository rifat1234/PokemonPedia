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
        let baseExperience:Int?
        let height:Int?
        let weight:Int?
        
        var body: some View {
            Section("Basic") {
                ListView(label: "Height", value: height, unit: " dm", icon: .figure)
                ListView(label: "Weight", value: weight, unit: " hg", icon: .weight)
                ListView(label: "Base Experience", value: baseExperience, icon: .experience)
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
                            .frame(width: 20)
                        Text(label)
                    }
                    Spacer()
                    Text("\(value)\(unit)")
                }
            } else {
                EmptyView()
            }
        }
    }
}
