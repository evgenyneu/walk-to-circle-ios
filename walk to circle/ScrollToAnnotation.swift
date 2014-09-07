//
//  ScrollToAnnotation.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 10/08/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class ScrollToAnnotation {
  // Returns the scroll amount (in view coordinates) to make the annotation visible
  func getScroll(mapSize: CGSize, annotationCoordinate: CGPoint) -> CGSize {
    var scroll = CGSize(width: 0, height: 0)
    let margin:CGFloat = 50 // additional scroll amount to show gap between annotation and screen edge
    let topMargin:CGFloat = 125

    if annotationCoordinate.x > (mapSize.width - margin)  {
      scroll.width = annotationCoordinate.x - mapSize.width + margin
    } else if annotationCoordinate.x < margin {
      scroll.width = annotationCoordinate.x - margin
    }

    if annotationCoordinate.y > (mapSize.height - margin)  {
      scroll.height = annotationCoordinate.y - mapSize.height + margin
    } else if annotationCoordinate.y < topMargin {
      scroll.height = annotationCoordinate.y - topMargin
    }

    return scroll
  }

  // converts distance (in pixels) in UIView to coordinate span (latitude and longitude)
  func convertDistance(distance: CGSize, toCoordinateSpanForMapView mapView: MKMapView) -> MKCoordinateSpan {
    var distanceAbs = CGSize(width: fabs(distance.width), height: fabs(distance.height))
    var rect = CGRect(origin: CGPoint(x: 0, y: 0), size: distance)
    let region = mapView.convertRect(rect, toRegionFromView: mapView)

    var latitudeDelta = region.span.latitudeDelta
    if distance.height > 0 { latitudeDelta *= -1 }

    var longitudeDelta = region.span.longitudeDelta
    if distance.width < 0 { longitudeDelta *= -1 }

    return MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
  }
}

