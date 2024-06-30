//
//  InfoVM.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import Observation

extension InfoView {
    @Observable class ViewModel {
        private let infos:[Info]
        private let title:String
        
        var sortedInfo:[Info] {
            infos.sorted{$0.name ?? "" < $1.name ?? ""}
        }
        
        var navigationTitle:String {
            title.capitalized
        }
        
        init(infos: [Info], title: String) {
            self.infos = infos
            self.title = title
        }
        
    }
}
