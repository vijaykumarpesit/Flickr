//
//  FLPhoto.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

/*  {
 "id": "23451156376", "owner": "28017113@N08", "secret": "8983a8ebc7", "server": "578",
 "farm": 1,
 "title": "Merry Christmas!", "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0
 }
*/

class FLPhoto:Codable {
    var id:String?
    var owner:String?
    var secret:String?
    var server:String?
    var farm:Int?
    var title:String?
    var ispublic:Int?
    var isfriend:Int?
    var isfamily:Int?
    
    func urlString() -> String  {
        return "https://farm\(self.farm ?? 0).static.flickr.com/\(String(describing: self.server ?? ""))/\(String(describing: self.id ?? ""))_\(String(describing: self.secret ?? ""))_n.jpg"
        }
}
