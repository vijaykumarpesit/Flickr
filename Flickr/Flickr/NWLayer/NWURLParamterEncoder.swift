//
//  NWURLParamterEncoder.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 13/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

class NWURLParamterEncoder {
    static func encode(request: inout URLRequest,  params: URLParams?) {
        guard let url = request.url, let params = params else {
            return
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var queryItems =  [URLQueryItem]()
        for (key,value) in params {
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            queryItems.append(queryItem)
        }
        urlComponents?.queryItems = queryItems
        request.url = urlComponents?.url
    }

}
