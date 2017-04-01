//
//  ViewController.swift
//  Run and Go Seek
//
//  Created by Branden Lee on 3/30/17.
//  Copyright © 2017 Panda Life. All rights reserved.
//

import UIKit
import Mapbox
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MGLMapViewDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCLLocation()
        setupMap()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMap(){
        let mapView = MGLMapView(frame: CGRect(x:0, y:20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20), styleURL: MGLStyle.streetsStyleURL(withVersion: 9))
        mapView.delegate = self
        
        // Tint the ℹ️ button and the user location annotation.
        mapView.tintColor = .darkGray
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 45.52245,
                                                 longitude: -122.67773),
                          zoomLevel: 13, animated: false)
        //The way to add points to the map
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        view.addSubview(mapView)
    }

    func setupCLLocation(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        print(long)
        print(lat)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        
        print(long)
        print(lat)
        
        //Do What ever you want with it
    }

}

