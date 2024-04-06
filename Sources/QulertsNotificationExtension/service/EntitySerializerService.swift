//
//  EntitySerializerService.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

class EntitySerializerService {

    private let encodingService: EncodingService
    private let jsonSerializerService: JsonSerializerService

    init(encodingService: EncodingService, jsonSerializerService: JsonSerializerService) {
        self.encodingService = encodingService
        self.jsonSerializerService = jsonSerializerService
    }

    func serializeToBase64(event: Dictionary<String, Any>) -> String? {
        let jsonValue = jsonSerializerService.serialize(value: event)
        if jsonValue != nil {
            let urlEncodedString = encodingService.getUrlEncodedString(value: jsonValue!)
            if urlEncodedString != nil {
                return encodingService.getBase64EncodedString(value: urlEncodedString!)
            }
        }
        return nil
    }

    func serializeToJson(event: Dictionary<String, Any>) -> String? {
        return jsonSerializerService.serialize(value: event)
    }
}
