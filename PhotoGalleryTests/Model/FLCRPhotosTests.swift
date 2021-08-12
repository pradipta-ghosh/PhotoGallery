//
//  FLCRPhotosTests.swift
//  PhotoGalleryTests
//
//  Created by Pradipta Ghosh on 12/08/21.
//

import XCTest
@testable import PhotoGallery

class FLCRPhotosTests: XCTestCase {

    func testModel() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let jsonModel = dataModel() ?? Data()
        let photo = try? jsonDecoder.decode(FLCRPhotos.self, from: jsonModel)
        XCTAssertTrue(photo?.items != nil)
        XCTAssertTrue(photo?.title == "Uploads from everyone")

    }
    
    func testModelForEmptyResponse() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let jsonModel = emptyDataModel() ?? Data()
        let photo = try? jsonDecoder.decode(FLCRPhotos.self, from: jsonModel)
        XCTAssertTrue(photo?.items == nil)
        XCTAssertTrue(photo?.title == nil)

    }
    
    private func dataModel() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "Data", withExtension: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: fileUrl) else { return nil }
        return jsonData
    }
    
    private func emptyDataModel() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "EmptyData", withExtension: "json") else { return nil }
        guard let jsonData = try? Data(contentsOf: fileUrl) else { return nil }
        return jsonData
    }

}
