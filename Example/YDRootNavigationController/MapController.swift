//
//  MapController.swift
//  YDRootNavigationController_Example
//
//  Created by One on 2024/3/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地图"
        mapView = MKMapView(frame: view.bounds)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.021251, longitudeDelta: 0.016093)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(24.4795100000, 118.0894800000);
        mapView.setRegion(MKCoordinateRegion(center: location, span: span), animated: true)
        view.addSubview(mapView)
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
