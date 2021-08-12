//
//  FLCRDashboardDetailsPageController.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 09/08/21.
//

import UIKit

class FLCRDashboardDetailsPageController: UIPageViewController {
    
    var index = 0
    var items: [FLCRPhoto] = []
    
    /// Method to initialize ViewController
    class func controller() -> FLCRDashboardDetailsPageController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsController = storyboard.instantiateViewController(identifier: FLCRConstants.DashboardDetailsPageControllerConstants.identifire) as? FLCRDashboardDetailsPageController
        return detailsController
    }
    
    /// didload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        if let startingViewController = self.viewControllerAtIndex(index: self.index) {
            self.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    /// Method to get viewcontroller at given index
    ///
    /// - parameter index: Int
    /// - returns UIViewController
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index >= 0, index < items.count {
            let controller = FLCRDashboardDetailsController.controller()
            controller?.index = index
            controller?.item = items[index]
            return controller
        }
        return nil
    }
    
    /// Method to get index of current view controller at pageviewcontroller
    ///
    /// - parameter viewController: UIViewController
    /// - returns Int
    func index(of viewController: UIViewController?) -> Int {
        guard let detailsController = viewController as? FLCRDashboardDetailsController else {
            return -1
        }
        return detailsController.index
    }
    
}

/// Extension of FLCRDashboardDetailsPageController to satisfy pageview controller datasource & delegate
extension FLCRDashboardDetailsPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.index(of: viewController)
        //if the index is the end of the array, return nil since we dont want a view controller after the last one
        if currentIndex == 0 {
            return nil
        }
        //increment the index to get the viewController after the current index
        self.index = currentIndex - 1
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.index(of: viewController)
        //if the index is 0, return nil since we dont want a view controller before the first one
        if currentIndex == items.count - 1 {
            return nil
        }
        //decrement the index to get the viewController before the current one
        self.index = currentIndex + 1
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return self.items.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
    
}
