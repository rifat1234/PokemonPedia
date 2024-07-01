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
                ListView(label: "Base Experience", value: baseExperience)
                ListView(label: "Height", value: height, unit: " dm")
                ListView(label: "Weight", value: weight, unit: " hg")
            }
        }
    }
    
    private struct ListView: View {
        let label: String
        let value: String?
        let unit: String

        init(label: String, value: Int?, unit: String = "") {
            self.label = label
            self.value = (value != nil) ? String(value ?? 0): nil
            self.unit = unit
        }
        
        var body: some View {
            if let value = value {
                HStack {
                    Text(label)
                    Spacer()
                    Text("\(value)\(unit)")
                }
            } else {
                EmptyView()
            }
        }
    }
}
