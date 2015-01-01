//
//  Annotations.swift
//
//  Created by Evgenii Neumerzhitckii on 22/06/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

private weak var walkAnnotation: Annotation?

class Annotations {
  class func show(coordinate: CLLocationCoordinate2D, title: String,
    newPin: Bool, mapView: MKMapView) -> Annotation {

    remove(mapView)

    let annotation = Annotation(centerCoordinate: coordinate,
      radius: WalkConstants.regionCircleRadiusMeters - 5)

    walkAnnotation = annotation

    annotation.newPin = newPin
    
    annotation.title = title

    mapView.addAnnotation(annotation)
    mapView.addOverlay(annotation)

    return annotation
  }

  class func remove(mapView: MKMapView) {
    if let currentAnnotation = walkAnnotation {
      mapView.removeAnnotation(currentAnnotation)
      mapView.removeOverlay(currentAnnotation)
      walkAnnotation = nil
    }
  }
}
