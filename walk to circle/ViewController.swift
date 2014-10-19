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
  @IBOutlet weak var rewindButton: UIButton!

  private var locationManager: CLLocationManager!
  private var zoomedToInitialLocation = false
  private var annotations: Annotations!
  private var callbackAfterRegionDidChange: (()->())?
  private var pindDropHeight: CGFloat = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    annotations = Annotations(mapView)

    initMapView()
  }

  private func initMapView() {
    mapView.delegate = self
    mapView.showsUserLocation = true
  }

  @IBAction func onPlay() {
    placeCircleOnMap()

    showRewindButton()

    iiAnimator.rotate3dOut(startButton)
    iiAnimator.fadeOut(startButton)

    iiAnimator.rotate3dIn(rewindButton)
    iiAnimator.fadeIn(rewindButton)
  }

  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.showStartButton()
    }
  }

  private func showStartButton() {
    if !startButton.hidden { return }
    startButton.setTitle("", forState: UIControlState.Normal)
    startButton.hidden = false
    iiSounds.shared.play(iiSoundType.blop, atVolume: 0.1)
    iiAnimator.bounce(startButton)
  }

  private func showRewindButton() {
    if !rewindButton.hidden { return }
    rewindButton.setTitle("", forState: UIControlState.Normal)
    rewindButton.hidden = false
  }

  // Place pin on the map
  // ---------------
  private func placeCircleOnMap() {
    annotations.removeAll()

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    if InitialMapZoom.needZoomingBeforePlay(mapView) {
      doAfterRegionDidChange {
        iiQ.runAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      InitialMapZoom.zoomToLocation(mapView, userLocation: mapView.userLocation, animated: true)
    } else {
      self.placePin(coordinate)
    }
  }

  private func placePin(coordinate: CLLocationCoordinate2D) {
    let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
      startButton: startButton, willDropAt: coordinate)

    let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
    pindDropHeight =  coordinateInView.y - scrollNeeded.height

    ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
      DropPin.placeCircleOnMapAndAnimate(self.mapView, coordinate: coordinate,
        annotations: self.annotations)
    }
  }

  private func doAfterRegionDidChange(callback: ()->()) {
    callbackAfterRegionDidChange = callback
  }
}

// MapView Delegate
// ------------------------------

typealias VCExtensionMapViewDelegate = ViewController

extension VCExtensionMapViewDelegate {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    zoomToInitialLocation()
  }

  func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }

  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
    DropPin.playPinDropSound(pindDropHeight)
  }
}

