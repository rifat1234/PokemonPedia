//
//  InfoVM.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import Observation
import PokemonCore

extension InfoDataView {
    @Observable 
    class ViewModel {
        private let infoData:InfoData
        
        var sortedInfo:[Info] {
            infoData.infos.sorted{$0.name ?? "" < $1.name ?? ""}
        }
        
        var navigationTitle:String {
            infoData.title.capitalized
        }
        
        init(infoData:InfoData) {
            self.infoData = infoData
        }
        
    }
}
