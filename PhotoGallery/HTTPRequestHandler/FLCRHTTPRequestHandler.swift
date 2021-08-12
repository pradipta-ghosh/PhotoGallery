//
//  FLCRHTTPRequestHandler.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import UIKit
import Alamofire

typealias PhotoDataResponseCompletion = ((FLCRPhotos?, Error?) -> ())

class FLCRHTTPRequestHandler: NSObject {

    /// Making this class as Singleton class
    static let sharedInstance = FLCRHTTPRequestHandler()
    
    /// Overriding init method and making it private as it is a singleton class.
    private override init() { }
    
    func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager.default?.isReachable ?? false
    }
    
    /// Method to fetch public photos via http request
    func fetchPublicPhotos<T: Decodable>(of type: T.Type, completion: PhotoDataResponseCompletion?) {
        let params = [ "format": "json", "nojsoncallback": "1"]
        let url = FLCRConstants.baseURL + FLCRConstants.urlPaths.publicPhotos
        let request = AF.request(url, parameters: params)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        request.responseDecodable(of: FLCRPhotos.self, decoder: jsonDecoder) { (response) in
            completion?(response.value, response.error)
        }
    }
    
}
