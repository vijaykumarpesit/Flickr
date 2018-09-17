//
//  FLPhotoSearchResult.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

class FLPhotoSearchResult: Codable {
    var page:Double?
    var pages:Double?
    var perpage:Double?
    var total:String?
    var photo:[FLPhoto]?
}
