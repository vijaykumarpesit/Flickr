//
//  FLPhotoCollectionCellViewModel.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import Foundation
import UIKit

protocol FLPhotoCollectionCellViewModelProtocol {
    func fetchImage(completion: @escaping (UIImage?, String) ->Void)
    var imageURLString: String {get}
    var imageURL: URL{get set}
}

final class FLPhotoCollectionCellViewModel: FLPhotoCollectionCellViewModelProtocol {
 
    //Using DI for ImageCache && imageDownloadHandler .We can use image cache at any level like viewController level, global level, Hence haven't defined something like cache manager and get image from cachemanager
    var imageCache: NSCache<NSString, UIImage>?
    var imageDownloader: FLImageDownloaderProtocol
    var imageURL: URL
    var imageURLString: String {
        return imageURL.absoluteString
    }
    
    required init(imageCache: NSCache<NSString, UIImage>?, imageURL: URL, imageDownloader: FLImageDownloaderProtocol) {
        self.imageCache = imageCache
        self.imageURL = imageURL
        self.imageDownloader = imageDownloader
    }
    
    func fetchImage(completion: @escaping (UIImage?, String) -> Void) {
        self.fetchImage(imageURL: self.imageURL, completion: completion)
    }
    
    private func fetchImage(imageURL: URL,completion: @escaping (UIImage?, String) -> Void) {
        let urlString = self.imageURL.absoluteString
        if let image = self.imageCache?.object(forKey: urlString as NSString) {
            completion(image,urlString)
        } else {
            self.imageDownloader.fetchImageData(url: self.imageURL) {[weak self] data in
                //Updating imageCache only in main thread to ensure thread safety
                DispatchQueue.main.async {[weak self] in
                    guard let data = data else {
                        completion(nil,urlString)
                        return
                    }
                    let image = UIImage.init(data: data)
                    self?.imageCache?.setObject(image!, forKey: imageURL.absoluteString as NSString)
                    completion(image,urlString)
                }
            }
        }
    }
    
}
