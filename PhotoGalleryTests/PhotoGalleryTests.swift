//
//  PhotoGalleryTests.swift
//  PhotoGalleryTests
//
//  Created by Pradipta Ghosh on 06/08/21.
//

import XCTest
@testable import PhotoGallery

class PhotoGalleryTests: XCTestCase {

    var dashboardController: FLCRDashboardController?
    var detailsController: FLCRDashboardDetailsController?
    var detailsPageController: FLCRDashboardDetailsPageController?
    
    override func setUp() {
        super.setUp()
    }
    
    private func initializeDashboard() {
        dashboardController = FLCRDashboardController.controller()
    }
    
    private func initializeDashboardDetails() {
        detailsController = FLCRDashboardDetailsController.controller()
    }
    
    private func initializeDashboardDetailsPageController() {
        detailsPageController = FLCRDashboardDetailsPageController.controller()
    }
    
    func testDashboard() {
        initializeDashboard()
        XCTAssertNotNil(dashboardController)
        XCTAssertNotNil(dashboardController?.view)
        XCTAssertNotNil((dashboardController?.view as? FLCRDashboardView)?.photoCollectionView)
    }
    
    func testDashboardDetails() {
        initializeDashboardDetails()
        XCTAssertNotNil(detailsController)
        XCTAssertNotNil(detailsController?.view)
        XCTAssertNotNil((detailsController?.detailsImageView))
    }
    
    func testDashboardDetailsPageController() {
        initializeDashboardDetailsPageController()
        XCTAssertNotNil(detailsPageController)
        XCTAssertNotNil(detailsPageController?.view)
    }
}
