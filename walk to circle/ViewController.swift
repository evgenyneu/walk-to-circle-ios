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

class ViewController: UIViewController, MKMapViewDelegate, iiOutputViewController,
  YiiButtonsDelegate, YiiMapDelegate {

  @IBOutlet weak var outputLabel: UILabel!

  private var locationManager: CLLocationManager!
  private var annotations: Annotations!
  private var callbackAfterRegionDidChange: (()->())?
  private var pindDropHeight: CGFloat = 0

  @IBOutlet var yiiButtons: YiiButtons!
  @IBOutlet var yiiMap: YiiMap!

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

//    annotations = Annotations(mapView)

    yiiMap.viewDidLoad()
    yiiMap.delegate = self

    yiiButtons.viewDidLoad()
    yiiButtons.delegate = self
  }

  // Place pin on the map
  // ---------------
  private func placeCircleOnMap() {
//    annotations.removeAll()
//
//    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
//      minDistanceKm: 1, maxDistanceKm: 3)
//
//    if InitialMapZoom.needZoomingBeforePlay(mapView) {
//      doAfterRegionDidChange {
//        iiQ.runAfterDelay(0.3) {
//          self.placePin(coordinate)
//        }
//      }
//
//      InitialMapZoom.zoomToLocation(mapView, userLocation: mapView.userLocation, animated: true)
//    } else {
//      self.placePin(coordinate)
//    }
  }

  private func placePin(coordinate: CLLocationCoordinate2D) {
//    let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
//      startButton: buttons.startButton, willDropAt: coordinate)
//
//    let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
//    pindDropHeight =  coordinateInView.y - scrollNeeded.height
//
//    ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
//      DropPin.placeCircleOnMapAndAnimate(self.mapView, coordinate: coordinate,
//        annotations: self.annotations)
//    }
  }

  private func doAfterRegionDidChange(callback: ()->()) {
    callbackAfterRegionDidChange = callback
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiButtonsDelegateImplementation = ViewController

extension YiiButtonsDelegateImplementation {
  func yiiButtonsDelegate_start() {
    placeCircleOnMap()
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiMapDelegateImplementation = ViewController

extension YiiMapDelegateImplementation {
  func yiiMapDelegate_mapIsReady() {
    yiiButtons.showStartButton()
  }
}




