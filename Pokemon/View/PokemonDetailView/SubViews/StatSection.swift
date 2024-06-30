//
//  StatSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    struct StatsSection: View {
        let stats: [Stat]?
        var body: some View {
            if let stats = stats {
                Section("Stats") {
                    ForEach(stats, id: \.self) { stat in
                        HStack {
                            Text(stat.stat?.name ?? "")
                                .font(.headline)
                            Spacer()
                            VStack {
                                Group {
                                    Text("Base Stat: \(String(stat.baseStat ?? 0))")
                                    Text("Effort: \(String(stat.effort ?? 0))")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .font(.caption)
                            
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
