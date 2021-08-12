//
//  FLCRDashboardInteractorTests.swift
//  PhotoGalleryTests
//
//  Created by Pradipta Ghosh on 12/08/21.
//

import XCTest
@testable import PhotoGallery

class FLCRDashboardInteractorTests: XCTestCase {

    func testFetchPublicPhotosDataResponse() {
        let interactor = FLCRDashboardInteractorDataResponse()
        let presenter = FLCRDashboardPresenterSpy()
        interactor.presenter = presenter
        
        interactor.fetchPublicPhotos()
        
        XCTAssert(interactor.fetchPhotosCalled, "fetchPublicPhotos() should ask the interactor to fetch public photos")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.presentPhotosCalled) != false), "Photos are fetched and ready to present in view")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.photos) != nil), "Valid data response")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.error) == nil), "No error")
    }
    
    func testFetchPublicPhotosEmptyResponse() {
        let interactor = FLCRDashboardInteractorEmptyResponse()
        let presenter = FLCRDashboardPresenterSpy()
        interactor.presenter = presenter
        
        interactor.fetchPublicPhotos()
        
        XCTAssert(interactor.fetchPhotosCalled, "fetchPublicPhotos() should ask the interactor to fetch public photos")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.presentPhotosCalled) == true), "Photos are fetched and ready to present in view")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.photos) == nil), "Empty response")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.error) == nil), "No error")
    }
    
    func testFetchPublicPhotosErrorResponse() {
        let interactor = FLCRDashboardInteractorErrorResponse()
        let presenter = FLCRDashboardPresenterSpy()
        interactor.presenter = presenter
        
        interactor.fetchPublicPhotos()
        
        XCTAssert(interactor.fetchPhotosCalled, "fetchPublicPhotos() should ask the interactor to fetch public photos")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.presentPhotosCalled) == true), "Photos are fetched and ready to present in view")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.photos) == nil), "Empty response")
        XCTAssert((((interactor.presenter as? FLCRDashboardPresenterSpy)?.error) != nil), "Error")
    }
    
}

class FLCRDashboardPresenterSpy: FLCRDashboardPresenter {
    
    var presentPhotosCalled = false
    var photos: FLCRPhotos?
    var error: Error?
    
    override func didReceivePublicPhotos(with photos: FLCRPhotos?, error: Error?) {
        presentPhotosCalled = true
        self.photos = photos
        self.error = error
    }
}

class FLCRDashboardInteractorDataResponse: FLCRDashboardInteractor {
    
    var fetchPhotosCalled = false
    
    override func fetchPublicPhotos() {
        fetchPhotosCalled = true
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let jsonModel = dataModel() ?? Data()
        let photos = try? jsonDecoder.decode(FLCRPhotos.self, from: jsonModel)
        self.presenter?.didReceivePublicPhotos(with: photos, error: nil)
    }
    
    private func dataModel() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "Data", withExtension: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: fileUrl) else { return nil }
        return jsonData
    }
    
}

class FLCRDashboardInteractorEmptyResponse: FLCRDashboardInteractor {
    
    var fetchPhotosCalled = false
    
    override func fetchPublicPhotos() {
        fetchPhotosCalled = true
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let jsonModel = emptyDataModel() ?? Data()
        let photos = try? jsonDecoder.decode(FLCRPhotos.self, from: jsonModel)
        self.presenter?.didReceivePublicPhotos(with: photos, error: nil)
    }
    
    private func emptyDataModel() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "EmptyData", withExtension: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: fileUrl) else { return nil }
        return jsonData
    }
}

class FLCRDashboardInteractorErrorResponse: FLCRDashboardInteractor {
    
    var fetchPhotosCalled = false
    
    override func fetchPublicPhotos() {
        fetchPhotosCalled = true
        let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid item"])
        self.presenter?.didReceivePublicPhotos(with: nil, error: error)
    }
    
}
