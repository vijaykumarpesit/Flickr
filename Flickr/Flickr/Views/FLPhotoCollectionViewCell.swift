//
//  FLPhotoCollectionViewCell.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 16/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

final class FLPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var viewModel:FLPhotoCollectionCellViewModelProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(vm:FLPhotoCollectionCellViewModelProtocol) {
        self.viewModel = vm
        vm.fetchImage {  [weak self] (image,urlString) in
            if let image  = image,self?.viewModel?.imageURLString == urlString {
                self?.imageView.image = image
            }
        }
    }
    
     override func prepareForReuse() {
        self.imageView.image = UIImage.init(named: "loadingIcon")
        self.viewModel = nil
    }
}
