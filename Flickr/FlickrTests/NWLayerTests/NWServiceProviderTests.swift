//
//  NWServiceProviderTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 15/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class NWServiceProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformRequest() {
        let serviceProvider = NWServiceProvider.init(session: NWMockURLSession.init(resultData:"Test".data(using: .utf8), resultResponse:nil, error: nil))
        let endPoint = NWEndPoint.init(baseURL: URL(string: "https://google.com")!, pathComp: "images", method: .get, headers:nil, params:nil, body: nil)
        let expectation = XCTestExpectation(description: "Testing Data Task")
        serviceProvider.performRequest(endPoint: endPoint) { (data, respinse, error) in
            XCTAssertEqual("Test".data(using:.utf8), data,"Result Data not matching")
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)

    }
    
}
