//
//  FindViewController.swift
//  lostInVLG
//
//  Created by Ios Dev on 02/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import UIKit
import YandexMapKit

class FindOnMapViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapWindow.map!.isRotateGesturesEnabled = false
        mapView.mapWindow.map!.move(with:
            YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 17, azimuth: 0, tilt: 0))
        
        let scale = UIScreen.main.scale
        let userLocationLayer = mapView.mapWindow.map!.userLocationLayer
        userLocationLayer!.isEnabled = true
        userLocationLayer!.isHeadingEnabled = true
        userLocationLayer!.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        userLocationLayer!.setObjectListenerWith(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FindOnMapViewController: YMKUserLocationObjectListener {
    
    func onObjectAdded(with view: YMKUserLocationView?) {
        print("onObjectAdded")
        view!.pin!.setIconWith(UIImage(named: "account-black"))
        view!.arrow!.setIconWith(UIImage(named: "account-black"))
        view!.accuracyCircle!.fillColor = UIColor.clear
    }
    
    func onObjectRemoved(with view: YMKUserLocationView?) {
        print("onObjectRemoved")
    }
    
    func onObjectUpdated(with view: YMKUserLocationView?, event: YMKObjectEvent?) {
        print("onObjectUpdated")
        //mapView.mapWindow.map!.mapObjects!
        
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
