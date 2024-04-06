//
//  JsonSerializerService.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

class JsonSerializerService {
    func serialize(value: Dictionary<String, Any>) -> String? {
        let jsonSerialized = try? JSONSerialization.data(withJSONObject: value, options: [])
        if jsonSerialized != nil {
            return String(data: jsonSerialized!, encoding: .utf8)
        }
        return nil
    }
}
