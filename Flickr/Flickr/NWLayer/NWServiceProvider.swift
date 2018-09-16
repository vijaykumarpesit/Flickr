//
//  NWServiceProvider.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 13/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

class NWServiceProvider {
    let session: URLSession
    
    required init(session: URLSession) {
        self.session = session
    }
    
    @discardableResult func performRequest(endPoint: NWEndPointProtocol,completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask? {
        let request = NWRequestBuilder.buildRequest(from: endPoint)
        let task = self.session.dataTask(with:request, completionHandler: completionHandler)
        task.resume()
        return task
    }

}
