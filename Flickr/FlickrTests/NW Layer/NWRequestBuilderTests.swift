//
//  NWRequestBuilderTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 14/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class NWRequestBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildRequest() {
      let endPoint = NWEndPoint.init(baseURL: URL(string: "https://google.com")!, pathComp: "images", method: .get, headers:self.headers(), params: self.urlParams(), body: nil)
      let request = NWRequestBuilder.buildRequest(from: endPoint)
      XCTAssertEqual(request.url?.absoluteString, "https://google.com/images?method=flickr.photos.search&format=json&safe_search=1&nojsoncallback=1", "URL construction is broken")
      XCTAssertEqual(request.allHTTPHeaderFields, self.headers(),"Headers are not proper")

    }
    
    func headers() -> HTTPHeaders {
        return ["contnetType":"application/json"]
    }
    
    func urlParams() ->URLParams {
        return ["method": "flickr.photos.search",
                "format": "json",
                "nojsoncallback": "1",
                "safe_search": "1",
        ]
    }
}
