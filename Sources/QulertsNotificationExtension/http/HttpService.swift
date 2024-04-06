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
            var params = Dictionary<String, String>()
            params["e"] = event
            
            let endpoint = getCollectorUrl(path: "p.gif", params: params)
            session.doRequest(from: ApiGetJsonRequest(endpoint: endpoint).getUrlRequest()) { httpResult in
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

    private func getCollectorUrl(path: String, params: [String: String]) -> String {
        var components = URLComponents(string: "https://f.qulerts.com")!
        components.path = path.starts(with: "/") ? path : "/\(path)"
        let queryItems = params.map { (paramKey, paramValue) in
            URLQueryItem(name: paramKey, value: paramValue)
        }
        components.queryItems = queryItems
        return components.url!.absoluteString
    }

}
