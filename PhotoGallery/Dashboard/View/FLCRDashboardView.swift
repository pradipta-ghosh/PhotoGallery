//
//  FLCRDashboardView.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

protocol FLCRDashboardViewDelegate: class {
    func didSelectItem(at index: Int, photos: FLCRPhotos?)
}

class FLCRDashboardView: UIView {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    let cellIdentifire = "FLCRDashboardCollectionViewCell"
    weak var delegate: FLCRDashboardViewDelegate?
    
    var photos: FLCRPhotos?
    
    /// Reload collection view with fetched item
    ///
    /// - parameter photos: FLCRPhotos
    func reloadCollectionList(with photos: FLCRPhotos?) {
        self.photos = photos
        self.photoCollectionView.reloadData()
    }
    
    /// Method to sort by date taken
    func sortByDateTaken() {
        self.photos?.sortUsingDateTaken()
        self.photoCollectionView.reloadData()
    }
    
    /// Method to sort by date published
    func sortByDatePublished() {
        self.photos?.sortUsingDatePublished()
        self.photoCollectionView.reloadData()
    }

}
