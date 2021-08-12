//
//  FLCRLoadingView.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 08/08/21.
//

import UIKit

class FLCRLoadingView: UIView {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    /// Method to initialize view from nib
    class func fromNib() -> FLCRLoadingView? {
        return Bundle.main.loadNibNamed("FLCRLoadingView", owner: self, options: nil)?.first as? FLCRLoadingView
    }
    
}
