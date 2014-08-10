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
  func getScroll(mapSize: CGSize, annotationCoordinate: CGPoint) -> CGSize {
    var scroll = CGSize(width: 0, height: 0)

    if annotationCoordinate.x > mapSize.width  {
      scroll.width = annotationCoordinate.x - mapSize.width
    } else if annotationCoordinate.x < 0 {
      scroll.width = annotationCoordinate.x
    }

    if annotationCoordinate.y > mapSize.height  {
      scroll.height = annotationCoordinate.y - mapSize.height
    } else if annotationCoordinate.y < 0 {
      scroll.height = annotationCoordinate.y
    }

    return scroll
  }

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

