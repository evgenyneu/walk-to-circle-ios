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
  var annotations: Annotations!;

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    annotations = Annotations(mapView)

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

    var accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    isUserLocationDetected = true

    doInitialZoom(mapView.userLocation)

    if playAfterLocatedDetected {
      placeCircleOnMap()
    }
  }

  func placeCircleOnMap() {
    annotations.removeAll()

    var geo = Geo()
    var coordinate = geo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 5)

    annotations.add(coordinate, id: "Walk Here")
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

