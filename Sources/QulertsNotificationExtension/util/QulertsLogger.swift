//
//  QulertsLogger.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

import os

class QulertsLogger {
    private init() {

    }

    class func log(message: String) {
        os_log("%@.", message)
    }

}
