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

  func add(coordinate: CLLocationCoordinate2D, id: String) {
    if all[id] { return }

    var annotation = Annotation(centerCoordinate: coordinate, radius: 130)
    annotation.title = id
    all[id] = annotation
    mapView.addAnnotation(annotation)
    mapView.addOverlay(annotation)
    mapView.selectAnnotation(annotation, animated: true)
  }

  func remove(id: String) {
    if all[id] {
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
