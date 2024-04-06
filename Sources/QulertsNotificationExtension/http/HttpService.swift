//
//  HttpService.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation


class HttpService {

    private let session: HttpSession
    
    init(session: HttpSession) {
        self.session = session
    }

    func sendFeedback(payload: String?) {
        if let event = payload {
            var request =  URLRequest(url: URL(string: "https://f.qulerts.com/p.gif?e=\(event)")!)
            request.httpMethod = "GET"
            
            session.doRequest(from: request) { httpResult in
                if httpResult.isValidStatus() {
                    QulertsLogger.log(message: "Qulerts collector returned \(httpResult.getStatusCode())")
                } else {
                    QulertsLogger.log(message: "Qulerts collector error. Detail: \(httpResult.toString())")
                }
            }
        }
    }

    func downloadContent(endpoint: String?, with completionHandler: @escaping (HttpDownloadableResult?) -> Void) {
        session.downloadTask(with: endpoint) { result in
            if result != nil {
                completionHandler(HttpDownloadableResult(path: result!.getPath()))
            } else {
                completionHandler(nil)
            }
        }
    }

}
