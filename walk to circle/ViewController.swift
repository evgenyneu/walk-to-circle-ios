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
  @IBOutlet weak var startButton: UIButton!
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
    let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 3500, 3500)
    mapView.setRegion(region, animated:animated)
  }


  func zoomToInitialLocation() {
    let accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    if zoomedToInitialLocation { return }
    zoomedToInitialLocation = true

    zoomToLocation(mapView.userLocation, animated: false)

    mapView.userLocation.title = NSLocalizedString("You are here",
      comment: "Short message shown above user location on the map")

    showCalloutAfterDelay(mapView.userLocation, delay: 1, {
      self.hideCalloutAfterDelay(self.mapView.userLocation, delay: 3)
      self.startButton.hidden = false;
    })

    if playAfterZoomedToInitialLocation {
      placeCircleOnMap()
    }
  }

  func placeCircleOnMap() {
    annotations.removeAll()

    let geo = Geo()
    let coordinate = geo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    let mapWidth = Geo().mapRectWidthInMeters(mapView.visibleMapRect)

//    if mapWidth < 2500 || mapWidth > 8000 || !mapView.userLocationVisible {
//      doAfterRegionDidChange {
//        self.placeCircleOnMapAndAnimate(coordinate)
//      }
//
//      zoomToLocation(mapView.userLocation, animated: true)
//    } else {
//      self.placeCircleOnMapAndAnimate(coordinate)
//    }

    self.placeCircleOnMapAndAnimate(coordinate)

    var point = mapView.convertCoordinate(coordinate, toPointToView: mapView)
//    println("point: \(point.x),\(point.y)")
//    println("button frame: \(startButton.frame)")

//    var overlaps = ButtonOverlap().buttonOverlapsPin(startButton.frame, withAnnotation: point)
//    println("button overlaps?: \(overlaps)")
//    var coordinateRegion = mapView.convertRect(startButton.frame,
//                                                toRegionFromView: mapView)
//
//    println("coordinate region, center: \(coordinateRegion.center.latitude), \(coordinateRegion.center.longitude), span: \(coordinateRegion.span.latitudeDelta), \(coordinateRegion.span.longitudeDelta)")



//    println("visible map view origin \(mapView.visibleMapRect.origin.x), \(mapView.visibleMapRect.origin.y) size: \(mapView.visibleMapRect.size.height), \(mapView.visibleMapRect.size.width)")
  }

  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    self.mapView.selectAnnotation(annotation, animated: true)
    hideCalloutAfterDelay(annotation, delay: 5)
  }

  func showCalloutAfterDelay(annotation: MKAnnotation, delay: Double, callback: (() -> ())? = nil) {
    doAfterDelay(delay) {
      self.mapView.selectAnnotation(annotation, animated: false)
      callback?()
    }
  }

  func hideCalloutAfterDelay(annotation: MKAnnotation, delay: Double) {
    doAfterDelay(delay) {
      self.mapView.deselectAnnotation(annotation, animated: false)
    }
  }

  func doAfterDelay(delaySeconds: Double, callback: ()->()) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
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

