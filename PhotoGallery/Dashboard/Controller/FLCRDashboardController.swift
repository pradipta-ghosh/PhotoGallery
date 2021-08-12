//
//  FLCRDashboardController.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit

class FLCRDashboardController: FLCRLoadingController {

    var interactor: FLCRDashboardInteractor?
    let refreshControl = UIRefreshControl()
    
    /// Method to initialize ViewController
    class func controller() -> FLCRDashboardController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardController = storyboard.instantiateViewController(identifier: FLCRConstants.DashboardConstants.identifire) as? FLCRDashboardController
        return dashboardController
    }
    
    /// didload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Gallery"
        (self.view as? FLCRDashboardView)?.delegate = self
        initializeInteractor()
        configureRefreshControl()
        fetchPublicPhotos(showLoadingInidicator: true)
    }
    
    /// Configure refresh control for pull to refresh
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        (self.view as? FLCRDashboardView)?.photoCollectionView.addSubview(refreshControl)
    }

    /// Method to initialize interactor
    private func initializeInteractor() {
        interactor = FLCRDashboardInteractor()
        interactor?.presenter = FLCRDashboardPresenter()
        interactor?.presenter?.delegate = self
    }
    
    /// Method to show sort option in navigation bar
    private func showSortOption() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
    }
    
    /// Method to hide sort option from navigation bar
    private func hideFilterOption() {
        navigationItem.rightBarButtonItem = nil
    }
    
    /// Metyod to fetch public photos from API
    private func fetchPublicPhotos(showLoadingInidicator: Bool = false) {
        guard FLCRHTTPRequestHandler.sharedInstance.isNetworkReachable() else {
            debugPrint("Network not reachable")
            self.showError(with: "No Network", message: "You don't have any active network connection. Please check your network connection and try again.")
            return
        }
        if showLoadingInidicator {
            self.showLoadingView()
        }
        interactor?.fetchPublicPhotos()
    }
    
    /// Handle pull to refresh
    @objc func handleRefreshControl() {
        fetchPublicPhotos()
    }
    
    /// Method will be called when sort option will be clicked
    @objc func sortTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let shortByCreated = UIAlertAction(title: "Date Taken", style: .default) { (_) in
            alertController.dismiss(animated: true) { [weak self] in
                (self?.view as? FLCRDashboardView)?.sortByDateTaken()
            }
        }
        let shortByModyfied = UIAlertAction(title: "Date Published", style: .default) { (_) in
            alertController.dismiss(animated: true) { [weak self] in
                (self?.view as? FLCRDashboardView)?.sortByDatePublished()
            }
        }
        alertController.addAction(shortByCreated)
        alertController.addAction(shortByModyfied)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/// Extension of FLCRDashboardController, will confirm FLCRDashboardPresenterDelegate methods
extension FLCRDashboardController: FLCRDashboardPresenterDelegate {
    
    func didReceivePublicPhotos(with photos: FLCRPhotos?, error: Error?) {
        self.refreshControl.endRefreshing()
        self.hideLoadingView()
        if let error = error {
            self.hideFilterOption()
            self.showError(with: "Error!", message: error.localizedDescription)
            return
        }
        self.showSortOption()
        (self.view as? FLCRDashboardView)?.reloadCollectionList(with: photos)
    }
    
}

/// Private extension to show error message
private extension FLCRDashboardController {
    
    func showError(with title: String, message: String?) {
        (self.view as? FLCRDashboardView)?.reloadCollectionList(with: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            alertController.dismiss(animated: true) { [weak self] in
                self?.fetchPublicPhotos()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FLCRDashboardController: FLCRDashboardViewDelegate {
    
    func didSelectItem(at index: Int, photos: FLCRPhotos?) {
        if let items = photos?.items, let controller = FLCRDashboardDetailsPageController.controller() {
            controller.index = index
            controller.items = items
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

