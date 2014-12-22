//
//  Annotations.swift
//  Geo Regions Test
//
//  Created by Evgenii Neumerzhitckii on 22/06/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Annotations {
  var mapView: MKMapView!
  var all = Dictionary<String, Annotation>()

  init(_ mapView: MKMapView) {
    self.mapView = mapView
  }

  func add(coordinate: CLLocationCoordinate2D, title: String, newPin: Bool) -> Annotation {
    if all[title] != nil { return all[title]! }

    let annotation = Annotation(centerCoordinate: coordinate,
      radius: iiWalkRegionOverlayCircleRadiusMeters)

    annotation.newPin = newPin
    
    annotation.title = title
    all[title] = annotation
    mapView.addAnnotation(annotation)
    mapView.addOverlay(annotation)

    return annotation;
  }

  func remove(id: String) {
    if all[id] != nil {
      mapView.removeAnnotation(all[id])
      mapView.removeOverlay(all[id])
      all[id] = nil
    }
  }

  func removeAll() {
    for (id, annotation) in all {
      remove(id)
    }
  }
}
