//
//  FLCRDashboardPresenter.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

protocol FLCRDashboardPresenterDelegate: class {
    func didReceivePublicPhotos(with photos: FLCRPhotos?, error: Error?)
}

class FLCRDashboardPresenter: NSObject {

    /// Hold instance of controller
    weak var delegate: FLCRDashboardPresenterDelegate?
    
    /// Method will notify controller after fetching data
    ///
    /// - Parameter photos: FLCRPhotos
    /// - Parameter error: Error
    func didReceivePublicPhotos(with photos: FLCRPhotos?, error: Error?) {
        delegate?.didReceivePublicPhotos(with: photos, error: error)
    }
}
