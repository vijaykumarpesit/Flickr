//
//  FLPhotoDisplayVC.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

final class FLPhotoDisplayVC: UIViewController {
    private let imageCellReuseID = "imageCellReuseID"
    private let imageCellFooter = "imageCellFooter"
    private var cellViewModels = [FLPhotoCollectionCellViewModelProtocol]()
    
    var viewModel:FLPhotoDisplayViewModelProtocol!
    lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()
    
    let imageDownloader = FLImageDownloader()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerResubaleComponents()
    }
}

extension FLPhotoDisplayVC {
    private func registerResubaleComponents() {
        collectionView.register(UINib.init(nibName:"FLPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:imageCellReuseID)
        collectionView.register(UINib.init(nibName:"FLPhotoCollectionViewFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: imageCellFooter)
        
    }
}

extension FLPhotoDisplayVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:imageCellReuseID, for: indexPath) as! FLPhotoCollectionViewCell
        if let photo = viewModel.dataSource.itemAtIndexPath(indexPath) {
            var cellViewModel: FLPhotoCollectionCellViewModelProtocol?
            if (indexPath.row < self.cellViewModels.count) {
                cellViewModel = self.cellViewModels[indexPath.row]
            } else {
                cellViewModel = FLPhotoCollectionCellViewModel.init(imageCache:imageCache, imageURL:URL(string:photo.urlString())!, imageDownloader: imageDownloader)
                cellViewModels.append(cellViewModel!)
            }
            cell.configure(vm: cellViewModel!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.bounds.width / 3) - (2 * 1)
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.dataSource.numberOfItems() > 0 && !viewModel.endOfResults() {
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
        collectionView.isHidden = true
        viewModel.dataSource.queryText = searchBar.text
        viewModel.loadMorePhotos { (loaded) in
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

extension FLPhotoDisplayVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if viewModel.dataSource.numberOfItems() > 0 && offsetY > contentHeight - scrollView.frame.size.height {
            viewModel.loadMorePhotos { (loaded) in
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
