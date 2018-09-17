//
//  FLPhotoDisplayViewModel.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation

protocol FLPhotoDisplayViewModelProtocol {
    var dataSource:FLPhotoDataSourceProtocol {get set}
    func loadMorePhotos(completion:@escaping (Bool) ->Void)
    func endOfResults() ->Bool
}

final class FLPhotoDisplayViewModel: FLPhotoDisplayViewModelProtocol {
    var dataSource:FLPhotoDataSourceProtocol

    init(dataSource: FLPhotoDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func loadMorePhotos(completion: @escaping (Bool) -> Void){
        if (dataSource.state == .FLPhotoDataSourceLoading || dataSource.state == .FLPhotoDataSourceEndOfResults) {
            completion(false)
            return
        } else {
            dataSource.fetchNextBatch { (state) in
                if state == .FLPhotoDataSourceFailed {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }

    func endOfResults() ->Bool {
        return dataSource.state == .FLPhotoDataSourceEndOfResults
    }

}
