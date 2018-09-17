//
//  FLPhotoDataSourceProtocol.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation
protocol FLPhotoDataSourceProtocol:AnyObject {
    var state:FLPhotoDataSourceState{ get }
    var queryText:String? {get set}
    func numberOfItems() -> Int
    func itemAtIndexPath(_ indexPath:IndexPath) -> FLPhoto?
    func fetchNextBatch(completion:@escaping(FLPhotoDataSourceState) -> Void)
}


enum FLPhotoDataSourceState:Int {
    case FLPhotoDataSourceDefault = 0
    case FLPhotoDataSourceLoading
    case FLPhotoDataSourceFinished
    case FLPhotoDataSourceFailed
    case FLPhotoDataSourceEndOfResults
}
