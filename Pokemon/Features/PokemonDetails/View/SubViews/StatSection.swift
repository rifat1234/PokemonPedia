//
//  StatSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import SwiftUI
import PokemonCore

extension PokemonDetailsView {
    struct StatsSection: View {
        fileprivate struct Const {
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
                        StatCellView(stat: stat)
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
    
    /// `StatCellView` determine which image and label to choose from `DataType`
    private struct StatCellView: View {
        let stat: Stat
        
        var body: some View {
            HStack {
                HStack {
                    // `DataType` is selected using name as rawValue
                    let dataType = DataType(rawValue: stat.stat?.name?.lowercased() ?? DataType.unknown.rawValue ) ?? .unknown
                    Image(systemName: dataType.imageName)
                        .frame(width: Const.cellIconSize)
                    Text(stat.stat?.name ?? "")
                }
                Spacer()
                VStack {
                    Group {
                        Text("\(StatsSection.Const.baseStatLabel): \(String(stat.baseStat ?? 0))")
                        Text("\(StatsSection.Const.effortLabel): \(String(stat.effort ?? 0))")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .font(.caption2)
            }
        }
    }
    
    /// `DataType` determine which image to choose and data determined by rawValue of the enum
    private enum DataType: String {
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
}
