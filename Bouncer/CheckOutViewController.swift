//
//  GeofenceViewController.swift
//  Bouncer
//
//  Created by Sotaro Sugimoto on 2017/04/01.
//  Copyright © 2017 Panda Life. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locator = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = self
        locator.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func locationPreCheck() -> Bool {
        var auth = CLLocationManager.authorizationStatus()
        if auth == .notDetermined {
            locator.requestAlwaysAuthorization()
            auth = CLLocationManager.authorizationStatus()
        }
        return auth == .authorizedAlways && CLLocationManager.locationServicesEnabled()
    }
    
    @IBAction func makeGeofence(_ sender: UIButton) {
        if locationPreCheck() {
            print("Make Geofence")
            let circleOverlay = MKCircle.init(center: (locator.location?.coordinate)!, radius: 10.0)
            mapView.add(circleOverlay)
            print("Added to map")
            let circleFence = CLCircularRegion.init(center: (locator.location?.coordinate)!, radius: 10.0, identifier: "Here")
            locator.startMonitoring(for: circleFence)
        }
    }
    
    @IBAction func findUserLocation(_ sender: UIButton) {
        if locationPreCheck() {
            print("33.7564, -84.3889")
        }
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print("Renderer added")
        let rend = MKCircleRenderer.init(overlay: overlay)
        rend.strokeColor = UIColor.white
        rend.lineWidth = 1
        rend.fillColor = UIColor.purple.withAlphaComponent(0.4)
        return rend
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let alertController = UIAlertController.init(title: "Entered!", message: "Welcome to X", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true)
        
        //present(UIAlertController.init(title: "Entered!", message: "Welcome to X", preferredStyle: .alert), animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let alertController = UIAlertController.init(title: "Exited!", message: "Welcome to X", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true)
        //present(UIAlertController.init(title: "Exited!", message: "See you again!", preferredStyle: .alert), animated: true, completion: nil)
        
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
