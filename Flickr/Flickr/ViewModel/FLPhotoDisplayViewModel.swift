//
//  FLPhotoDisplayViewModel.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation
import UIKit

protocol FLPhotoDisplayViewModelProtocol {
    var dataSource:FLPhotoDataSourceProtocol {get set}
    func loadMorePhotos(completion:@escaping (Bool) ->Void)
    func endOfResults() ->Bool
    func childViewModelAtIndexPath(indexPath:IndexPath) -> FLPhotoCollectionCellViewModelProtocol?
    func searchPhotosWithQueryText(text:String?, completion:@escaping (Bool) ->Void)
}

final class FLPhotoDisplayViewModel: FLPhotoDisplayViewModelProtocol {
    var dataSource:FLPhotoDataSourceProtocol
    private var childViewModels:[FLPhotoCollectionCellViewModelProtocol] = [FLPhotoCollectionCellViewModelProtocol]()
    lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()
    let imageDownloader = FLImageDownloader()
    
    init(dataSource: FLPhotoDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func loadMorePhotos(completion: @escaping (Bool) -> Void){
        if (dataSource.state == .loading || dataSource.state == .endOfResults) {
            completion(false)
            return
        } else {
            dataSource.fetchNextBatch { (state) in
                if state == .failed {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func endOfResults() ->Bool {
        return dataSource.state == .endOfResults
    }
    
    func childViewModelAtIndexPath(indexPath:IndexPath) -> FLPhotoCollectionCellViewModelProtocol? {
        var cellViewModel: FLPhotoCollectionCellViewModelProtocol?
        if let photo = self.dataSource.itemAtIndexPath(indexPath) {
            if indexPath.row < childViewModels.count {
                cellViewModel = childViewModels[indexPath.row]
            } else {
                cellViewModel = FLPhotoCollectionCellViewModel.init(imageCache:imageCache, imageURL:URL(string:photo.urlString())!, imageDownloader: imageDownloader)
                
            }
        }
        return cellViewModel
    }
    
    func searchPhotosWithQueryText(text:String?, completion:@escaping (Bool) ->Void) {
        self.dataSource.queryText = text
        self.loadMorePhotos(completion: completion)
    }

}
