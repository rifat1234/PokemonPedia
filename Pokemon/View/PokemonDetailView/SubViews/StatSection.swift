//
//  StatSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI

extension PokemonDetailsView {
    enum Icon: String {
        case hp
        case attack
        case defense
        case specialAttack = "special attack"
        case specialDefense = "special defense"
        case speed
        case unknown
        
        var imageName:String {
            switch self {
            case .hp:
                "figure.tennis"
            case .attack:
                "figure.boxing"
            case .defense:
                "hand.raised"
            case .specialAttack:
                "figure.kickboxing"
            case .specialDefense:
                "hand.raised.fill"
            case .speed:
                "figure.run"
            case .unknown:
                "figure.run"
            }
        }
    }
    
    struct StatsSection: View {
        let stats: [Stat]?
        var body: some View {
            if let stats = stats {
                Section("Stats") {
                    ForEach(stats, id: \.self) { stat in
                        HStack {
                            HStack {
                                Image(systemName: (Icon(rawValue: stat.stat?.name?.lowercased() ?? "unknown") ?? .unknown).imageName)
                                    .frame(width:20)
                                Text(stat.stat?.name ?? "")
                            }
                            Spacer()
                            VStack {
                                Group {
                                    Text("Base Stat: \(String(stat.baseStat ?? 0))")
                                    Text("Effort: \(String(stat.effort ?? 0))")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .font(.caption2)
                            
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
