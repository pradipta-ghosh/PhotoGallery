//
//  FLCRDashboardInteractor.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

class FLCRDashboardInteractor: NSObject {
    
    /// Hold instance of presenter
    var presenter: FLCRDashboardPresenter?

    /// Method will notify presenter after fetching data from api
    func fetchPublicPhotos() {
        FLCRHTTPRequestHandler.sharedInstance.fetchPublicPhotos(of: FLCRPhotos.self) { [weak self] (photos, error) in
            self?.presenter?.didReceivePublicPhotos(with: photos, error: error)
        }
    }
}
