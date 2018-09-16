//
//  NWURLParamterEncoderTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 14/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class NWURLParamterEncoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncode() {
        var request:URLRequest = URLRequest(url:URL(string:"https://google.com")!)
        NWURLParamterEncoder.encode(request:&request, params:urlParams())
        let result =  "https://google.com?method=flickr.photos.search&format=json&safe_search=1&nojsoncallback=1"
        XCTAssertEqual(result,request.url?.absoluteString)
        
    }
    
    func urlParams() ->URLParams {
        return ["method": "flickr.photos.search",
                "format": "json",
                "nojsoncallback": "1",
                "safe_search": "1",
        ]
    }
}
