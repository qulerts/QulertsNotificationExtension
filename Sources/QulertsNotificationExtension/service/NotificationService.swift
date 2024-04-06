//
//  File.swift
//  
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

import UserNotifications

@objc public class NotificationService: NSObject {
    
    private let httpService: HttpService
    private let entitySerializerService: EntitySerializerService
    
    init(httpService: HttpService, entitySerializerService: EntitySerializerService) {
        self.httpService = httpService
        self.entitySerializerService = entitySerializerService
    }

    @objc public func handlePushNotification(request: UNNotificationRequest,
                                             bestAttemptContent: UNMutableNotificationContent,
                                             withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

        let source = request.content.userInfo["source"]
        if source != nil {
            let pushChannelId = source as? String
            if "qulerts" == pushChannelId! {
                pushMessageDelivered(pushContent: request.content.userInfo)
                let imageUrl = request.content.userInfo["image_url"] as? String
                if imageUrl != nil {
                    httpService.downloadContent(endpoint: imageUrl) { response in
                        if response != nil {
                            do {
                                let imageAttachment = try UNNotificationAttachment(identifier: "picture", url: response!.getPath(), options: nil)
                                bestAttemptContent.attachments = [imageAttachment]
                                contentHandler(bestAttemptContent)
                            } catch {
                                contentHandler(bestAttemptContent)
                                QulertsLogger.log(message: "unable to handle push notification image")
                            }
                        }
                    }
                } else {
                    contentHandler(bestAttemptContent)
                }
            }
        }
    }
    
    @objc public func pushMessageDelivered(pushContent: Dictionary<AnyHashable, Any>) {
        let pushId = getContentItem(key: "pushId", pushContent: pushContent)
        let campaignId = getContentItem(key: "campaignId", pushContent: pushContent)
        let campaignDate = getContentItem(key: "campaignDate", pushContent: pushContent)
        let customerId = getContentItem(key: "customerId", pushContent: pushContent)
        let pushReceivedEvent = FeedbackEvent.create(name: "d")
                .addParameter(key: "ci", value: campaignId!)
                .addParameter(key: "pi", value: pushId!)
                .addParameter(key: "c", value: customerId!)
                .addParameter(key: "cd", value: campaignDate!)
                .toMap()
        let serializedEvent = entitySerializerService.serializeToJson(event: pushReceivedEvent)
        httpService.sendFeedback(payload: serializedEvent)
    }
    
    private func getContentItem(key: String, pushContent: Dictionary<AnyHashable, Any>) -> String? {
        return pushContent[key] as? String
    }
}
