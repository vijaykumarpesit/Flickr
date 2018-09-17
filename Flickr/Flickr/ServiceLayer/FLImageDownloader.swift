//
//  FLImageDownloader.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

protocol FLImageDownloaderProtocol {
    func fetchImageData(url:URL, completionHandler: @escaping (Data?) -> Void)
    
}

class FLImageDownloader:FLImageDownloaderProtocol {
    lazy var nwServiceProvider:NWServiceProvider = self.initializeServiceProvider()
    
    private func initializeServiceProvider() ->NWServiceProvider  {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpMaximumConnectionsPerHost = 5
        let serviceProvider = NWServiceProvider.init(session: URLSession(configuration:sessionConfig))
        return serviceProvider
    }
    
    func fetchImageData(url:URL, completionHandler: @escaping (Data?) -> Void) {
        let endPoint:NWEndPointProtocol = NWEndPoint.init(baseURL:url, pathComp:nil, method:.get, headers:nil, params:nil, body: nil)
        self.nwServiceProvider.performRequest(endPoint: endPoint) { (data, response, error) in
            completionHandler(data)
        }
        
    }
}

