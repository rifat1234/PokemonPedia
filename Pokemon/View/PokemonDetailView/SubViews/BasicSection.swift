//
//  PokemonDetailsBaseSection.swift
//  Pokemon
//
//  Created by Rifat Monzur on 29/6/24.
//

import Foundation
import SwiftUI

extension PokemonDetailsView {
    /// `BasicSection` show basic details like base experience, height and weight
    struct BasicSection: View {
        fileprivate struct Const {
            static let sectionTitle = "Basic"
            static let cellIconSize:CGFloat = PokemonDetailsView.Const.cellIconSize
        }
        
        let baseExperience:Int?
        let height:Int?
        let weight:Int?
        
        var body: some View {
            Section(Const.sectionTitle) {
                BasicCellView(type: .height, value: height)
                BasicCellView(type: .weight, value: weight)
                BasicCellView(type: .experience, value: baseExperience)
            }
        }
    }
    
    /// `BasicCellView` determine which image and label to choose from `DataType`
    private struct BasicCellView: View {
        let value: String?
        let type: DataType

        init(type: DataType, value: Int?) {
            self.type = type
            self.value = (value != nil) ? String(value ?? 0): nil
        }
        
        var body: some View {
            if let value = value {
                HStack {
                    HStack {
                        Image(systemName: type.imageName)
                            .frame(width: PokemonDetailsView.Const.cellIconSize)
                        Text(type.rawValue)
                    }
                    Spacer()
                    Text("\(value)\(" " + type.unit)")
                }
            } else {
                EmptyView()
            }
        }
    }
    
    /// `DataType` determine which image and label to choose
    private enum DataType: String { // rawValue is the `label` of the cell
        case height = "Height"
        case weight = "Weight"
        case experience = "Base Experience"
        
        var imageName: String {
            switch self {
            case .height:
                "figure"
            case .weight:
                "scalemass"
            case .experience:
                "hourglass"
            }
        }
        
        var unit: String {
            switch self {
            case .height:
                "dm"
            case .weight:
                "hg"
            case .experience:
                ""
            }
        }
    }
}
