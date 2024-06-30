//
//  AlertType.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import Alamofire

enum AlertType {
    case networkError(_ error:Error? = nil)
    
    var title:String {
        switch self {
        case .networkError:
            "Network Connection Error"
        }
    }
    
    var message:String {
        switch self {
        case .networkError(let error):
            error?.asAFError?.localizedDescription ?? "Could not process the request. Please check your internet connection."
        }
    }
    
    var primaryButtonText:String {
        switch self {
        case .networkError:
            "Retry"
        }
    }
    
    var secondaryButtonText:String {
        switch self {
        case .networkError:
            "Cancel"
        }
    }
}

protocol AlertHandler {
    var alertType:AlertType { get }
    func showAlert(_ alertType: AlertType)
    var showAlert:Bool  { get set }
}
