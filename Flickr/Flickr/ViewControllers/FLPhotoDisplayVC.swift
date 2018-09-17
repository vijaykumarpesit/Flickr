//
//  FLPhotoDisplayVC.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

class FLPhotoDisplayVC: UIViewController {
    var viewModel:FLPhotoDisplayViewModelProtocol!
    let imageCellReuseID = "imageCellReuseID"
    let imageCellFooter = "imageCellFooter"
    lazy var imageCache:NSCache<NSString, UIImage> = initializeCache()
    let imageDownloader = FLImageDownloader()
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerResubaleComponents()
    }
}

extension FLPhotoDisplayVC {
    
    private func initializeCache()->NSCache<NSString, UIImage> {
        let cache = NSCache<NSString, UIImage>.init()
        cache.countLimit = 50
        return cache
    }
    
    private func registerResubaleComponents() {
        self.collectionView.register(UINib.init(nibName:"FLPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:imageCellReuseID)
        self.collectionView.register(UINib.init(nibName:"FLPhotoCollectionViewFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: imageCellFooter)
    }
}

extension FLPhotoDisplayVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:imageCellReuseID, for: indexPath) as! FLPhotoCollectionViewCell
        if let photo = self.viewModel.dataSource.itemAtIndexPath(indexPath) {
            let vm =  FLPhotoCollectionCellViewModel.init(imageCache:imageCache, imageURL:URL(string:photo.urlString())!, imageDownloader: imageDownloader)
            cell.viewModel = vm
            cell.configure()
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.bounds.width / 3) - (2 * 1)
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.viewModel.dataSource.numberOfItems() > 0 && !self.viewModel.endOfResults() {
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        } else {
            return CGSize(width:0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footer =  collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionFooter, withReuseIdentifier: imageCellFooter, for: indexPath)
            if let flFooter = footer as? FLPhotoCollectionViewFooter {
                return flFooter
            }
            return footer
            
        default:
            return UICollectionReusableView()
        }
        
    }

}

extension FLPhotoDisplayVC:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.collectionView.isHidden = true
        self.viewModel.dataSource.queryText = searchBar.text
        self.viewModel.loadMorePhotos { (loaded) in
            if (loaded){
                DispatchQueue.main.async { [weak self]  in
                    self?.collectionView.isHidden = false
                    self?.collectionView.reloadData()
                }
            }
        }
        
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FLPhotoDisplayVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if self.viewModel.dataSource.numberOfItems() > 0 && offsetY > contentHeight - scrollView.frame.size.height {
            self.viewModel.loadMorePhotos { (loaded) in
                if loaded {
                    DispatchQueue.main.async { [weak self]  in
                        self?.collectionView.isHidden = false
                        self?.collectionView.reloadData()
                    }
                }
            }
 
        }
    }
}
