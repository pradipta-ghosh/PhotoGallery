//
//  FLCRDashboardCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

class FLCRDashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoView.layer.borderWidth = 1.0
        self.photoView.layer.borderColor = UIColor.gray.cgColor
        self.photoView.layer.cornerRadius = 4.0
    }
    
    /// Configure collection view cell
    ///
    /// - parameter photoItem: FLCRPhoto
    func configureCell(with photoItem: FLCRPhoto?) {
        photoView.setImageFromURL(url: photoItem?.media.link, showIndicator: true)
    }
}
