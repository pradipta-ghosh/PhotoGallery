//
//  FLCRHTTPRequestHandlerTests.swift
//  PhotoGalleryTests
//
//  Created by Pradipta Ghosh on 12/08/21.
//

import XCTest
@testable import PhotoGallery

class FLCRHTTPRequestHandlerTests: XCTestCase {

    func testPublicPhotoAPI() {
        let completion = expectation(description: "Completion handler invoked")
        FLCRHTTPRequestHandler.sharedInstance.fetchPublicPhotos(of: FLCRPhotos.self) { (photos, error) in
            completion.fulfill()
            XCTAssertTrue(photos != nil, "Parsing success")
            XCTAssertTrue(error == nil, "No Error")
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

}
