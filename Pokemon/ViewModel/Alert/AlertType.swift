//
//  AlertType.swift
//  Pokemon
//
//  Created by Rifat Monzur on 30/6/24.
//

import Foundation
import Alamofire

/// `AlertType` contains all the information required to show a type of **Alert**
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
        case .networkError:
            "Couldn't process the request. Please check your internet connection."
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


