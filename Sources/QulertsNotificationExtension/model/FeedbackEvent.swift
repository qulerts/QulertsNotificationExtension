//
//  FeedbackEvent.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

class FeedbackEvent {
    private var event: Dictionary<String, Any> = Dictionary<String, Any>()

    class func create(name: String) -> FeedbackEvent {
        let feedbackEvent = FeedbackEvent()
        feedbackEvent.event["n"] = name
        return feedbackEvent
    }

    func addParameter(key: String, value: Any) -> FeedbackEvent {
        event[key] = value
        return self
    }

    func toMap() -> Dictionary<String, Any> {
        return event
    }

}
