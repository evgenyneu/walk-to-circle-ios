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

class ViewController: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var mapView: MKMapView!
  var didInitiaZoom = false
  var locationManager: CLLocationManager!
  var zoomedToInitialLocation = false
  var playAfterZoomedToInitialLocation = false
  var annotations: Annotations!
  @IBOutlet weak var startButton: UIButton!
  var callbackAfterRegionDidChange: (()->())?

  var pindDropHeight: CGFloat = 0

  let soundPlayer = SoundPlayer()

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

      self.showStartButton()
    })

    if playAfterZoomedToInitialLocation {
      placeCircleOnMap()
    }
  }

  func showStartButton() {
    startButton.hidden = false
    soundPlayer.play(SoundType.blop, atVolume: 0.1)
    Animator().bounce(startButton)
  }

  func placeCircleOnMap() {
    annotations.removeAll()

    let geo = Geo()
    let coordinate = geo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    let mapWidth = Geo().mapRectWidthInMeters(mapView.visibleMapRect)

    if mapWidth < 1500 || mapWidth > 8000 || !mapView.userLocationVisible {
      doAfterRegionDidChange {
        self.doAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      zoomToLocation(mapView.userLocation, animated: true)
    } else {
      self.placePin(coordinate)
    }
  }

  func placePin(coordinate: CLLocationCoordinate2D) {
    ensureCoordinateVisibility(coordinate) {
      self.placeCircleOnMapAndAnimate(coordinate)
    }
  }

  // Make sure `coordinate` is visibile. If not - scroll the map.
  func ensureCoordinateVisibility(coordinate: CLLocationCoordinate2D, doAfter: ()->()) {

    let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)

    let scrollDelta = ScrollToAnnotation().getScroll(mapView.frame.size,
      annotationCoordinate: coordinateInView)

    let coordinateCorrected = CGPoint(
      x: coordinateInView.x - scrollDelta.width,
      y: coordinateInView.y - scrollDelta.height)

    let vericalCorrection = ButtonOverlap().verticalCorrection(startButton.frame,
      pinCoordinate: coordinateCorrected)

    println("Button vertical correction: \(vericalCorrection)")
    println("scroll delta before \(scrollDelta.height)")
    let deltaScrollHeightCorrected = scrollDelta.height + vericalCorrection
    println("scroll delta after \(deltaScrollHeightCorrected)")

    pindDropHeight = coordinateInView.y - scrollDelta.height

    if scrollDelta.width != 0 || scrollDelta.height != 0 {

      var coordinateSpan = ScrollToAnnotation().convertDistance(scrollDelta,
        toCoordinateSpanForMapView: mapView)

      var newCenter = CLLocationCoordinate2D(
        latitude: mapView.region.center.latitude + coordinateSpan.latitudeDelta,
        longitude: mapView.region.center.longitude + coordinateSpan.longitudeDelta)

      UIView.animateWithDuration(0.2,
        animations: {
          self.mapView.region.center = newCenter
        },
        completion: { finished in
          doAfter()
        }
      )
    } else {
      doAfter()
    }
  }

  func placeCircleOnMapAndAnimate(coordinate: CLLocationCoordinate2D) {
    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    mapView.selectAnnotation(annotation, animated: true)
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

  private func playPinDropSound() {
    if pindDropHeight == 0 { return }


    if pindDropHeight > 200 {
      soundPlayer.play(SoundType.fall, atVolume: 0.01)
    }

    var showPinAfterDelay = Double(pindDropHeight) / 1200.0

    if showPinAfterDelay < 0.2 { showPinAfterDelay = 0.2 }

    doAfterDelay(showPinAfterDelay) {
      self.soundPlayer.play(SoundType.ballBounce, atVolume: 0.5)
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

  func mapView(mapView: MKMapView!,
    didSelectAnnotationView view: MKAnnotationView!) {

    playPinDropSound()
  }
}

