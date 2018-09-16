//
//  NWRequestBuilder.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 10/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

class NWRequestBuilder {
    
    static func buildRequest(from:NWEndPointProtocol) ->URLRequest {
        var url = from.baseURL
        if let pathComp = from.pathComponent {
            url = url.appendingPathComponent(pathComp)
        }
        var request = URLRequest(url: url, cachePolicy:.reloadRevalidatingCacheData, timeoutInterval: 8)
        request.httpMethod = from.httpMethod.rawValue
        request.allHTTPHeaderFields = from.headers
        request.httpBody = from.body
        NWURLParamterEncoder.encode(request: &request, params: from.parameters)
        return request
    }
    
}
