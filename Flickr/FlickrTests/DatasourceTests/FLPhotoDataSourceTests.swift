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
        let expectation = XCTestExpectation(description:"")
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.numberOfItems() == 50,"Mismatch in number of items")
            XCTAssert(self.ds.state == FLPhotoDataSourceState.finished,"Mismatch in state")
            expectation.fulfill()   
        }
        
        wait(for: [expectation], timeout: 10.0)

    }
    
    func testEndOfResultsData() {
        let expectation = XCTestExpectation(description: "")
        self.ds.pageNumber = 11625
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.state == FLPhotoDataSourceState.endOfResults,"Mismatch in state")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testResetDataOnNewSearchText()  {
        self.ds.queryText = "hello"
        let expectation = XCTestExpectation(description: "")
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.numberOfItems() == 50,"Mismatch in number of items")
            XCTAssert(self.ds.state == FLPhotoDataSourceState.finished,"Mismatch in state")
            self.ds.queryText = "food"
            XCTAssert(self.ds.numberOfItems() == 0,"Resetting data on new query failed")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testDataSourceState() {
        let expectation = XCTestExpectation(description: "")
        ds.fetchNextBatch { (state) in
            XCTAssert(self.ds.state == FLPhotoDataSourceState.finished,"Mismatch in state")
            expectation.fulfill()
        }
        XCTAssert(self.ds.state == FLPhotoDataSourceState.loading,"Mismatch in state")
        
        wait(for: [expectation], timeout: 10.0)
        
    }
}
