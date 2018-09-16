//
//  File.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 13/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

public protocol NWEndPointProtocol {
    var baseURL:URL {get}
    var pathComponent:String? {get}
    var httpMethod:HTTPMethod {get}
    var headers:HTTPHeaders?{get}
    var parameters:URLParams?{get}
    var body:Data?{get}

}

class NWEndPoint: NWEndPointProtocol {
    var baseURL:URL
    var pathComponent:String?
    var httpMethod = HTTPMethod.get
    var headers:HTTPHeaders?
    var parameters:URLParams?
    var body:Data?
    
    init(baseURL:URL, pathComp:String?, method:HTTPMethod, headers:HTTPHeaders?, params:URLParams?,body:Data?) {
        self.baseURL = baseURL
        self.pathComponent = pathComp
        self.httpMethod = method
        self.headers = headers
        self.parameters = params
    }
}


