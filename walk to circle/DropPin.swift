//
//  PlacePin.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 12/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class DropPin {
  class func placeCircleOnMapAndAnimate(mapView: MKMapView, coordinate: CLLocationCoordinate2D,
    annotations: Annotations) {

    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    mapView.selectAnnotation(annotation, animated: true)
    Annotation.hideCalloutAfterDelay(mapView, annotation: annotation, delay: 5)
  }
}
