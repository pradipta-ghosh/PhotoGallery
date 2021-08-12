//
//  FLCRLoadingController.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 09/08/21.
//

import UIKit

class FLCRLoadingController: UIViewController {

    private var loadingView: FLCRLoadingView?
    
    /// didload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// Method to show loading view
    func showLoadingView() {
        guard let contentView = FLCRLoadingView.fromNib() else {
            return
        }
        loadingView = contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentView.indicator.startAnimating()
    }
    
    /// Method to hide loading view
    func hideLoadingView() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.loadingView?.alpha = 0.0
        } completion: { [weak self] (_) in
            self?.loadingView?.removeFromSuperview()
        }
    }
    
}
