//
//  InitialMapZoom.swift
//
//  Class functions for loozing map at a specific location.
//
//  Created by Evgenii Neumerzhitckii on 12/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

private let iiMAP_SIZE_METERS:CLLocationDistance = 3_000

class InitialMapZoom {
  class func zoomToLocation(mapView: MKMapView, userLocation: MKUserLocation, animated: Bool) {
    let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate,
      iiMAP_SIZE_METERS, iiMAP_SIZE_METERS)

    mapView.setRegion(region, animated:animated)
  }

  class func needZoomingBeforePlay(mapView: MKMapView) -> Bool {
    return !(isZoomLevelOk(mapView.visibleMapRect) && mapView.userLocationVisible)
  }

  // Zooms map to user location. It is called once after the app has started.
  class func zoomToInitialLocation(mapView: MKMapView, onZoomFinished: ()->()) {
    let accuracy = mapView.userLocation.location.horizontalAccuracy
    if accuracy < 0 || accuracy > 100 { return } // Not accurate enough

    InitialMapZoom.zoomToLocation(mapView, userLocation: mapView.userLocation, animated: false)

    mapView.userLocation.title = NSLocalizedString("You are here",
      comment: "Short message shown above user location on the map")

    Annotation.showCalloutAfterDelay(mapView, annotation: mapView.userLocation, delay: 1) {
      Annotation.hideCalloutAfterDelay(mapView,
        annotation: mapView.userLocation, delay: 3)

      onZoomFinished()
    }
  }

  private class func isZoomLevelOk(mapRect: MKMapRect) -> Bool {
    let mapSize = iiGeo.mapSizeInMeters(mapRect)
    let maxSize = max(mapSize.width, mapSize.height)
    let minSize = min(mapSize.width, mapSize.height)

    return minSize < 6_000 && maxSize > 3_000
  }
}