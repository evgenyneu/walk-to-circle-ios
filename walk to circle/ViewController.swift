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

  override func viewDidLoad() {
    super.viewDidLoad()

    initMapView()
  }

  func initMapView() {
    mapView.delegate = self
    mapView.showsUserLocation = true;
  }

  func doInitialZoom(userLocation: MKUserLocation) {
    if didInitiaZoom { return }
    didInitiaZoom = true
    var region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 1000, 1000)
    mapView.setRegion(region, animated:false)
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

