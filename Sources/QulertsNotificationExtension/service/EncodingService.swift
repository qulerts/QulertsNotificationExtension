//
//  EncodingService.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

class EncodingService {
    
    func getUrlEncodedString(value: String) -> String? {
        return value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    func getBase64EncodedString(value: String) -> String {
        return Data(value.utf8).base64EncodedString()
    }
    
}

