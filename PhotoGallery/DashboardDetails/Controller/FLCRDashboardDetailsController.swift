//
//  FLCRDashboardDetailsController.swift
//  PhotoGallery
//
//  Created by Pradipta Ghosh on 09/08/21.
//

import UIKit

class FLCRDashboardDetailsController: UIViewController {

    var index = 0
    var item: FLCRPhoto?
    @IBOutlet weak var detailsImageView: UIImageView!
    
    class func controller() -> FLCRDashboardDetailsController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsController = storyboard.instantiateViewController(identifier: FLCRConstants.DashboardDetailsConstants.identifire) as? FLCRDashboardDetailsController
        return detailsController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var imageLink = item?.media.link
        imageLink = imageLink?.replacingOccurrences(of: "_m", with: "_b")
        detailsImageView.setImageFromURL(url: imageLink, showIndicator: true, indictorColor: .white)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
