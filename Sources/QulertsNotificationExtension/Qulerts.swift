//
//  Qulerts.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

@objc public final class Qulerts : NSObject {
    
    @objc public class func notification() -> NotificationService {
        return NotificationService(httpService: HttpService(session: URLSession.shared), entitySerializerService: EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService()))
    }
}


