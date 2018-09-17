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
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now()+1) {
            if let url = Bundle.main.url(forResource:"APIResponse", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf:url)
                    completionHandler(jsonData,nil,nil)
                } catch {
                    completionHandler(nil,nil,nil)
                }
            } else {
                completionHandler(nil, nil,nil)
            }
        }
        
        return mockDataTask
    }
}
