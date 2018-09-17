//
//  FLPhotoSearchService.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation
let APIKey  = "3e7cc266ae2b0e0d78e279ce8e361736"

protocol FLPhotoSearchServiceProtocol {
    func searchPhotos(searchText: String, page: Int, perPageCount: Int, completionHandler: @escaping (FLPhotosCollection?, Error?) -> Void)
}

class FLPhotoSearchService:FLPhotoSearchServiceProtocol {
   lazy var nwServiceProvider:NWServiceProvider = self.initializeServiceProvider()
    
    func searchPhotos(searchText: String, page: Int, perPageCount: Int, completionHandler: @escaping (FLPhotosCollection?, Error?) -> Void) {
        let params = urlParams(searchText:searchText, page: page, perPageCount: perPageCount)
        let endPoint:NWEndPointProtocol = NWEndPoint.init(baseURL:self.baseURL, pathComp: self.pathComponent, method: self.httpMethod, headers:nil, params: params, body: nil)
        self.nwServiceProvider .performRequest(endPoint: endPoint) {(data, response, error) in
            guard let data = data else{
                completionHandler(nil,error)
                return
            }
            do{
               let response = try JSONDecoder().decode(FLPhotosCollection.self, from: data)
                completionHandler(response,nil)
            } catch {
                completionHandler(nil,error)
            }
        }
        
    }
    
   private func initializeServiceProvider() ->NWServiceProvider  {
        let serviceProvider = NWServiceProvider.init(session: URLSession(configuration: .default))
        return serviceProvider
    }
    
    func urlParams(searchText:String, page:Int, perPageCount:Int) ->URLParams {
        return ["method": "flickr.photos.search",
                "api_key": APIKey,
                "format": "json",
                "nojsoncallback": "1",
                "safe_search": "1",
                "text": searchText,
                "page": "\(page)",
                "per_page": "\(perPageCount)"
        ]
    }
    
    var baseURL:URL  {
        return URL(string: "https://api.flickr.com")!
    }
    var pathComponent:String? {
        return "services/rest"
    }
    var httpMethod:HTTPMethod {
        return .get
    }
    
}
