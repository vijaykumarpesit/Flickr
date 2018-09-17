//
//  FLPhotoDataSource.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

let batchSize = 50

class FLPhotoDataSource:FLPhotoDataSourceProtocol {
    var state:FLPhotoDataSourceState = .FLPhotoDataSourceDefault
    var results:[FLPhoto] = [FLPhoto]()
    var pageNumber:Int = 1
    lazy var searchService:FLPhotoSearchService = initialiseSearchService()
    var queryText:String? {
        didSet{
            if oldValue != queryText {
                resetDataSource()
            }
        }
    }
    
   private func initialiseSearchService() -> FLPhotoSearchService {
        let searchService = FLPhotoSearchService.init()
        return searchService
    }
    
    func numberOfItems() -> Int {
        return results.count
        
    }
    
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> FLPhoto? {
        if indexPath.row < results.count  {
            return results[indexPath.row]
        }
        return nil
    }
    
    func fetchNextBatch(completion:@escaping(FLPhotoDataSourceState) -> Void) {
        if self.state == .FLPhotoDataSourceLoading &&  self.state == .FLPhotoDataSourceEndOfResults {
            completion(self.state)
            return;
        }
        self.state = .FLPhotoDataSourceLoading
        let searchText = self.queryText ?? ""
        self.searchService.searchPhotos(searchText:searchText, page: self.pageNumber, perPageCount: batchSize) { (collection, error) in
            if let _ = error {
                self.state = .FLPhotoDataSourceFailed
            } else {
                self.state = .FLPhotoDataSourceFinished
                if let newResults = collection?.photos?.photo {
                    self.results += newResults
                }
                
                if let totol = collection?.photos?.total {
                    if (self.pageNumber*batchSize > Int(totol)!) {
                        self.state = .FLPhotoDataSourceEndOfResults
                    }
                }
                
                //Mark state as finished
                if (self.pageNumber * batchSize >= Int((collection?.photos?.total)!)!) {
                    self.state = .FLPhotoDataSourceEndOfResults
                }
                
                self.pageNumber += 1
                //Need to add end of result state
            }
            completion(self.state)
        }
        
    }

    private func resetDataSource() {
        self.results = [FLPhoto]()
        self.pageNumber = 1
        self.state = .FLPhotoDataSourceDefault
    }
}
