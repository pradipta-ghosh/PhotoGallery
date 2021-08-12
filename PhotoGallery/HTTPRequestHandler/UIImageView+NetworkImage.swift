//
//  UIImageView+NetworkImage.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 08/08/21.
//

import UIKit
import Alamofire

extension UIImageView {
    
    /// Method to show image from cache or from network
    ///
    /// - parameter url: String
    func setImageFromURL(url: String?, showIndicator: Bool = false, indictorColor: UIColor = .gray) {
        guard let imageURL = url else {
            self.image = nil
            return
        }
        if let cachedImage = ImageCache.sharedInstance.imageCache.object(forKey: imageURL as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            self.image = nil
            guard FLCRHTTPRequestHandler.sharedInstance.isNetworkReachable() else {
                return
            }
            var indicator: UIActivityIndicatorView?
            if showIndicator {
                let indicatorView = UIActivityIndicatorView(style: .large)
                indicatorView.color = indictorColor
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(indicatorView)
                indicator = indicatorView
                NSLayoutConstraint.activate([
                    indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
                indicatorView.startAnimating()
            }
            let request = AF.request(imageURL)
            request.validate(contentType: ["image/*"])
            request.responseData { (response) in
                if response.response?.statusCode == 200, let imageData = response.value, let downloadedImage = UIImage(data: imageData) {
                    ImageCache.sharedInstance.imageCache.setObject(downloadedImage, forKey: imageURL as NSString)
                    self.image = downloadedImage
                } else {
                    self.image = nil
                }
                indicator?.stopAnimating()
                indicator?.removeFromSuperview()
            }
        }
    }
    
}

class ImageCache: NSObject {
    
    static let sharedInstance = ImageCache()
    private override init() { }
    let imageCache = NSCache<NSString, AnyObject>()
    
}
