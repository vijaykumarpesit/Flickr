//
//  File.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 13/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation


class NWEndPoint {
    var baseURL: URL
    var pathComponent: String?
    var httpMethod = HTTPMethod.get
    var headers: HTTPHeaders?
    var parameters: URLParams?
    var body: Data?
    
    init(baseURL: URL, pathComp: String?, method: HTTPMethod, headers: HTTPHeaders?, params: URLParams?, body: Data?) {
        self.baseURL = baseURL
        self.pathComponent = pathComp
        self.httpMethod = method
        self.headers = headers
        self.parameters = params
    }
}


