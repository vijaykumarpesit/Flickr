//
//  FLPhotoDisplayVMTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 17/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class FLMockDataSource: FLPhotoDataSourceProtocol {
    var queryText: String?
    var state:FLPhotoDataSourceState = .FLPhotoDataSourceDefault
    var results:[FLPhoto] = [FLPhoto]()
    var pageNumber:Int = 1
    
    func numberOfItems() -> Int {
        return 10
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> FLPhoto? {
        return nil
    }
    
    func fetchNextBatch(completion: @escaping (FLPhotoDataSourceState) -> Void) {
        self.state = .FLPhotoDataSourceFinished
        completion(self.state)
    }
}

class FLPhotoDisplayVMTests: XCTestCase {
    let vm = FLPhotoDisplayViewModel.init(dataSource: FLMockDataSource())
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadMorePhotos() {
        let expectation = XCTestExpectation(description: "Testing load more photos")
        vm.loadMorePhotos { (success) in
            XCTAssert(success,"loading photos failed")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
}
