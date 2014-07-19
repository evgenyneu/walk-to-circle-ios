//
//  ViewController.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 6/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
                            
  @IBOutlet var mapView: MKMapView

  var didInitiaZoom = false
  var locationManager: CLLocationManager!;

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    initMapView()
  }

  func initMapView() {
    mapView.delegate = self
  }

  func doInitialZoom(userLocation: MKUserLocation) {
    var region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 5000, 5000)
    mapView.setRegion(region, animated:false)
  }

  @IBAction func onPlay() {
//    var region = CLCircularRegion(center: center,
//      radius: CLLocationDistance(100), identifier: id)
//
//    region.notifyOnEntry = true
//    mapView.userLocation.location.co

  }

  func distinationWithDistanceAndBearing(fromCoord: CLLocationCoordinate2D,
    atDistanceKm: Double,
    atBearingDegrees: Double) {
//      var fromLatRadians =
  }

  func degreesToRadians(degrees: Double) -> Double {
    return (degrees / 180.0) * M_PI;
  }
}

// MapView Delegate
// ------------------------------

typealias VCExtensionMapViewDelegate = ViewController

extension VCExtensionMapViewDelegate {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    doInitialZoom(userLocation)
  }
}

