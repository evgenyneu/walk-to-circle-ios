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
  var isUserLocationDetected = false;
  var playAfterLocatedDetected = false;


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
    mapView.showsUserLocation = true
  }

  func doInitialZoom(userLocation: MKUserLocation) {
    var region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 5000, 5000)
    mapView.setRegion(region, animated:false)
  }

  func userLocationDetected() {
    if isUserLocationDetected { return }
    isUserLocationDetected = true

    doInitialZoom(mapView.userLocation)

    if playAfterLocatedDetected {
      placeCircleOnMap()
    }
  }

  func placeCircleOnMap() {
  }

  @IBAction func onPlay() {
    if !isUserLocationDetected {
      playAfterLocatedDetected = true
    } else {
      placeCircleOnMap()
    }
  }
}

// MapView Delegate
// ------------------------------

typealias VCExtensionMapViewDelegate = ViewController

extension VCExtensionMapViewDelegate {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    userLocationDetected()
  }
}

