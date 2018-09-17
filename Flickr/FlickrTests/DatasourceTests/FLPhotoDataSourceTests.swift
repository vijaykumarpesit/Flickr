//
//  FLPhotoDataSourceTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 17/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class FLPhotoDataSourceTests: XCTestCase {
    var ds:FLPhotoDataSource!
    override func setUp() {
        super.setUp()
        self.ds = FLPhotoDataSource()
        let searchService = FLPhotoSearchService()
        searchService.nwServiceProvider = NWServiceProvider.init(session: NWMockURLSession())
        ds.searchService = searchService
    }
    
    func testFetchMoreData() {
        let expectation = XCTestExpectation(description: "Testing Data Task")
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.numberOfItems() == 50,"Mismatch in number of items")
            XCTAssert(self.ds.state == FLPhotoDataSourceState.FLPhotoDataSourceFinished,"Mismatch in state")
            expectation.fulfill()   
        }
        
        wait(for: [expectation], timeout: 10.0)

    }
    
    func testEndOfResultsData() {
        let expectation = XCTestExpectation(description: "Testing Data Task")
        self.ds.pageNumber = 11625
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.state == FLPhotoDataSourceState.FLPhotoDataSourceEndOfResults,"Mismatch in state")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testResetDataOnNewSearchText()  {
        self.ds.queryText = "hello"
        let expectation = XCTestExpectation(description: "Testing Data Task")
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.numberOfItems() == 50,"Mismatch in number of items")
            XCTAssert(self.ds.state == FLPhotoDataSourceState.FLPhotoDataSourceFinished,"Mismatch in state")
            self.ds.queryText = "food"
            XCTAssert(self.ds.numberOfItems() == 0,"Resetting data on new query failed")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

}
