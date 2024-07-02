//
//  AlertHandler.swift
//  Pokemon
//
//  Created by Rifat on 02/07/2024.
//

import Foundation

/// `AlertHandler` protocol is conformed by ViewModel to show alerts of `AlertType`
protocol AlertHandler {
    var alertType:AlertType { get }
    var showAlert:Bool  { get set }
    func showAlert(_ alertType: AlertType)
    func alertPrimaryButtonAction(_ alertType: AlertType) async // Optional
    func alertSecondaryButtonAction(_ alertType: AlertType) async // Optional
}

extension AlertHandler {
    func alertPrimaryButtonAction(_ alertType: AlertType) async {}
    func alertSecondaryButtonAction(_ alertType: AlertType) async {}
}
