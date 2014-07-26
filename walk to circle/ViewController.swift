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

  @IBOutlet weak var mapView: MKMapView!
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

  func zoomToLocation(userLocation: MKUserLocation, animated: Bool) {
    var region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 3500, 3500)
    mapView.setRegion(region, animated:animated)
  }

  func userLocationDetected() {
    if isUserLocationDetected { return }

    var accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    isUserLocationDetected = true

    zoomToLocation(mapView.userLocation, animated: false)

    if playAfterLocatedDetected {
      placeCircleOnMap()
    }
  }

  func placeCircleOnMap() {
    annotations.removeAll()

    var geo = Geo()
    var coordinate = geo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    var mapWidth = Geo().mapRectWidthInMeters(mapView.visibleMapRect)

    if mapWidth < 2500 || mapWidth > 6000 || !mapView.userLocationVisible {
      zoomToLocation(mapView.userLocation, animated: true)
      var time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
      dispatch_after(time, dispatch_get_main_queue(), {
        self.placeCircleOnMapAndAnimate(coordinate)
      })
    } else {
      self.placeCircleOnMapAndAnimate(coordinate)
    }
  }

  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    var annotation = annotations.add(coordinate, id: "Walk Here")
    self.mapView.selectAnnotation(annotation, animated: true)
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

