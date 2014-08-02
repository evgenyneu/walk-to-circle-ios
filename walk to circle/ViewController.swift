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
  var locationManager: CLLocationManager!
  var zoomedToInitialLocation = false
  var playAfterZoomedToInitialLocation = false
  var annotations: Annotations!
  var callbackAfterRegionDidChange: (()->())?

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


  func zoomToInitialLocation() {
    var accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    if zoomedToInitialLocation { return }
    zoomedToInitialLocation = true

    zoomToLocation(mapView.userLocation, animated: false)

    mapView.userLocation.title = "You are here"

    showCalloutAfterDelay(mapView.userLocation, {
      self.hideCalloutAfterDelay(self.mapView.userLocation)
      })

    if playAfterZoomedToInitialLocation {
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
      doAfterRegionDidChange {
        self.placeCircleOnMapAndAnimate(coordinate)
      }

      zoomToLocation(mapView.userLocation, animated: true)
    } else {
      self.placeCircleOnMapAndAnimate(coordinate)
    }
  }

  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    var annotation = annotations.add(coordinate, id: "Memorize and walk here")
    self.mapView.selectAnnotation(annotation, animated: true)
    hideCalloutAfterDelay(annotation)
  }

  func showCalloutAfterDelay(annotation: MKAnnotation, callback: (() -> ())? = nil) {
    doAfterDelay(2) {
      self.mapView.selectAnnotation(annotation, animated: false)
      callback?()
    }
  }

  func hideCalloutAfterDelay(annotation: MKAnnotation) {
    doAfterDelay(3) {
      self.mapView.deselectAnnotation(annotation, animated: false)
    }
  }

  func doAfterDelay(delaySeconds: Double, callback: ()->()) {
    var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue()) {
      callback();
    }
  }

  @IBAction func onPlay() {
    if !zoomedToInitialLocation {
      playAfterZoomedToInitialLocation = true
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
    zoomToInitialLocation()
  }

  func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
    if (animated) { return }

    if let cb = callbackAfterRegionDidChange {
      doAfterDelay(0.3) { cb () }
    }
    callbackAfterRegionDidChange = nil
  }

  func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }

  func doAfterRegionDidChange(callback: ()->()) {
    callbackAfterRegionDidChange = callback
  }
}

