//
//  Qulerts.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation
import UserNotifications

@objc public final class QulertsNotification : NSObject {
    
    @objc public class func didReceiveNotificationRequest(
        request: UNNotificationRequest,
                                                 bestAttemptContent: UNMutableNotificationContent?,
                                                 withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) -> Void {
                                                     NotificationService(httpService: HttpService(session: URLSession.shared), entitySerializerService: EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())).didReceiveNotificationRequest(request: request, bestAttemptContent: bestAttemptContent, withContentHandler: contentHandler)
    }
}


