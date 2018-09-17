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
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = NWURLSessionTaskMock()
        guard let file = Bundle.main.url(forResource: "APIResponse", withExtension: "json"), let data = try? Data(contentsOf: file, options: .mappedIfSafe) else {
            completionHandler(nil,nil, nil)
            return mockDataTask
        }
        completionHandler(data, nil,nil)

        return mockDataTask
    }
}
