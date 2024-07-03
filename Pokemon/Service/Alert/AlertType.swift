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
    case audioNetworkError
    case audioPlayingError
    
    var title:String {
        switch self {
        case .networkError, .audioNetworkError:
            "Network Connection Error"
        case .audioPlayingError:
            "Audio Player Error"
        }
    }
    
    var message:String {
        switch self {
        case .networkError, .audioNetworkError:
            "Couldn't process the request. Please check your internet connection."
        case .audioPlayingError:
            "Couldn't play audio. Please try again later."
        }
    }
    
    var primaryButtonText:String {
        switch self {
        case .networkError:
            "Retry"
        case .audioNetworkError, .audioPlayingError:
            "OK"
        }
    }
    
    var secondaryButtonText: String? {
        switch self {
        case .networkError:
            "Cancel"
        case .audioNetworkError, .audioPlayingError:
            nil
        }
    }
    
}


