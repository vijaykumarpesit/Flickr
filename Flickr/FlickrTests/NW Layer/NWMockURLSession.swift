//
//  NWMockURLSession.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 15/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

class NWURLSessionTaskMock: URLSessionDataTask {
    override func resume() {
    }
}


class NWMockURLSession: URLSession {
    var data: Data?
    var resultResponse:URLResponse?
    var error:Swift.Error?
    
    init(resultData:Data?, resultResponse:URLResponse?, error:Swift.Error?) {
        self.data = resultData
        self.error = error
        self.resultResponse = resultResponse
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = NWURLSessionTaskMock()
        completionHandler(self.data, resultResponse,error)
        return mockDataTask
    }
}
