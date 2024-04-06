//
//  ApiGetJsonRequest.swift
//  qulerts-notification-extension
//
//  Created by YILDIRIM ADIGÜZEL on 4/6/24.
//

import Foundation

class ApiGetJsonRequest: HttpTask {
    
    private let url: URL
    
    init(endpoint: String) {
        self.url = URL(string: endpoint)!
    }
    
    func getUrlRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
