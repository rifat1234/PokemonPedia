//
//  Alertify.swift
//  Pokemon
//
//  Created by Rifat on 16/07/2024.
//

import Foundation
import SwiftUI

/// `Alertify` is responsible for viewing alert for protocol `AlertHandler`
struct Alertify: ViewModifier {
    @State var alertHandler: AlertHandler
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertHandler.alertType.title,
                isPresented: $alertHandler.showAlert
            ) {
                Button(alertHandler.alertType.primaryButtonText) { // mandatory button
                    Task {
                        await alertHandler.alertPrimaryButtonAction(alertHandler.alertType)
                    }
                }
                if let secondaryButtonLabel = alertHandler.alertType.secondaryButtonText { // optional secondary button
                    Button(secondaryButtonLabel) {
                        Task {
                            await alertHandler.alertSecondaryButtonAction(alertHandler.alertType)
                        }
                    }
                }
                
            } message: {
                Text(alertHandler.alertType.message)
            }
    }
}

extension View {
    func alertify(_ alertHandler: AlertHandler) -> some View {
        modifier(Alertify(alertHandler: alertHandler))
    }
}
