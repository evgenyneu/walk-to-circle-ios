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

class ViewController: UIViewController, MKMapViewDelegate, iiOutputViewController, ButtonsDelegate {

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var outputLabel: UILabel!

  private var locationManager: CLLocationManager!
  private var zoomedToInitialLocation = false
  private var annotations: Annotations!
  private var callbackAfterRegionDidChange: (()->())?
  private var pindDropHeight: CGFloat = 0

  @IBOutlet var buttons: YiiButtons!

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    annotations = Annotations(mapView)

    initMapView()
    buttons.viewDidLoad()
    buttons.delegate = self
  }

  private func initMapView() {
    mapView.delegate = self
    mapView.showsUserLocation = true
  }

  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.buttons.showStartButton()
    }
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
      startButton: buttons.startButton, willDropAt: coordinate)

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

// ButtonsDelgate
// ------------------------------

typealias ButtonsDelegateImplementation = ViewController

extension ButtonsDelegateImplementation {
  func buttonsDelegateStart() {
    placeCircleOnMap()
  }
}

