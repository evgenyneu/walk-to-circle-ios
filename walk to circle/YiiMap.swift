//
//  iiMap.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 23/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class YiiMap: NSObject, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!

  var delegate: YiiMapDelegate?

  private var zoomedToInitialLocation = false

  func viewDidLoad() {
    mapView.delegate = self
    mapView.showsUserLocation = true
  }

  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.delegate?.yiiMapDelegate_mapIsReady()
    }
  }
}

// MapView Delegate
// ------------------------------

typealias MKMapViewDelegateImplementation = YiiMap

extension MKMapViewDelegateImplementation {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    zoomToInitialLocation()
  }

  func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
//    callbackAfterRegionDidChange?()
//    callbackAfterRegionDidChange = nil
  }

  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
//    DropPin.playPinDropSound(pindDropHeight)
  }
}
