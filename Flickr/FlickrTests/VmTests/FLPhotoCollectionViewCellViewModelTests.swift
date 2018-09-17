//
//  FLPhotoCollectionViewCellViewModelTests.swift
//  FlickrTests
//
//  Created by Vijaykumar Bhat on 17/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import XCTest

class FLMockImageDownloader: FLImageDownloaderProtocol {
    
    func fetchImageData(url: URL, completionHandler: @escaping (Data?) -> Void) {
        let image =  UIImage.init(named: "loadingIcon")
        let data =  UIImagePNGRepresentation(image!)
        completionHandler(data)
    }
    
    
}

class FLPhotoCollectionViewCellViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchImage() {
        let vm = FLPhotoCollectionCellViewModel.init(imageCache:NSCache<NSString, UIImage>(), imageURL:URL(string: "https://google.com")!, imageDownloader: FLMockImageDownloader())
        vm.fetchImage { (image, urlString) in
            XCTAssert((image != nil),"returned image is nil")
        }
    }
    
    
}
