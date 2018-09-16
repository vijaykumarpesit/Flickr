//
//  NetworkConstants.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 10/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

public enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}

public typealias HTTPHeaders = [String:String]
public typealias URLParams = [String:String]

