//
//  ViewController.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 6/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class ViewController: UIViewController, MKMapViewDelegate, iiOutputViewController {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var startButton: UIButton!

  var didInitiaZoom = false
  var locationManager: CLLocationManager!
  var zoomedToInitialLocation = false
  var playAfterZoomedToInitialLocation = false
  var annotations: Annotations!
  var callbackAfterRegionDidChange: (()->())?

  let MAP_SIZE_METERS:CLLocationDistance = 3_000

  var pindDropHeight: CGFloat = 0

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

  // Extract: Zoom to location
  func zoomToLocation(userLocation: MKUserLocation, animated: Bool) {
    let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate,
      MAP_SIZE_METERS, MAP_SIZE_METERS)

    mapView.setRegion(region, animated:animated)
  }


  // Extract: Zoom to location
  func zoomToInitialLocation() {
    let accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    if zoomedToInitialLocation { return }
    zoomedToInitialLocation = true

    zoomToLocation(mapView.userLocation, animated: false)

    mapView.userLocation.title = NSLocalizedString("You are here",
      comment: "Short message shown above user location on the map")

    Annotation.showCalloutAfterDelay(mapView, annotation: mapView.userLocation, delay: 1) {
      Annotation.hideCalloutAfterDelay(self.mapView,
        annotation: self.mapView.userLocation, delay: 3)

      self.showStartButton()
    }

    if playAfterZoomedToInitialLocation {
      placeCircleOnMap()
    }
  }

  func showStartButton() {
    startButton.hidden = false
    iiSounds.shared.play(iiSoundType.blop, atVolume: 0.1)
    Animator().bounce(startButton)
  }

  // Extract: Place pin: 1
  func placeCircleOnMap() {
    annotations.removeAll()

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    if needZoomingBeforePlay {
      doAfterRegionDidChange {
        iiQ.runAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      zoomToLocation(mapView.userLocation, animated: true)
    } else {
      self.placePin(coordinate)
    }
  }

  // Extract: Zoom to location
  var needZoomingBeforePlay: Bool {
    return !(InitialMapZoom.isZoomLevelOk(mapView.visibleMapRect) && mapView.userLocationVisible)
  }

  

  // Extract: Place pin
  func placePin(coordinate: CLLocationCoordinate2D) {
    let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
      startButton: startButton, willDropAt: coordinate)

    let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
    pindDropHeight =  coordinateInView.y - scrollNeeded.height

    ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
      self.placeCircleOnMapAndAnimate(coordinate)
    }
  }

  // Extract: Place pin
  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    mapView.selectAnnotation(annotation, animated: true)
    Annotation.hideCalloutAfterDelay(mapView, annotation: annotation, delay: 5)
  }

  @IBAction func onPlay() {
    if !zoomedToInitialLocation {
      playAfterZoomedToInitialLocation = true
    } else {
      placeCircleOnMap()
    }
  }

  private func playPinDropSound() {
    if pindDropHeight == 0 { return }

    if pindDropHeight > 200 {
      iiSounds.shared.play(iiSoundType.fall, atVolume: 0.01)
    }

    var showPinAfterDelay = pow(Double(pindDropHeight) / 1200.0, 2.5)

    if showPinAfterDelay < 0.2 { showPinAfterDelay = 0.2 }

    iiQ.runAfterDelay(showPinAfterDelay) {
      iiSounds.shared.play(iiSoundType.ballBounce, atVolume: 0.5)
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
      iiQ.runAfterDelay(0.3, cb)
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

  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
    playPinDropSound()
  }
}

