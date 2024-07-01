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
        private struct Const {
            static let sectionTitle = "Stats"
            static let baseStatLabel = "Base Stat"
            static let effortLabel = "Effort"
            static let cellIconSize:CGFloat = PokemonDetailsView.Const.cellIconSize
        }
        
        let stats: [Stat]?
        var body: some View {
            if let stats = stats {
                Section(Const.sectionTitle) {
                    ForEach(stats, id: \.self) { stat in
                        HStack {
                            HStack {
                                let icon = Icon(rawValue: stat.stat?.name?.lowercased() ?? Icon.unknown.rawValue ) ?? .unknown
                                Image(systemName: icon.imageName)
                                    .frame(width: Const.cellIconSize)
                                Text(stat.stat?.name ?? "")
                            }
                            Spacer()
                            VStack {
                                Group {
                                    Text("\(Const.baseStatLabel): \(String(stat.baseStat ?? 0))")
                                    Text("\(Const.effortLabel): \(String(stat.effort ?? 0))")
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
