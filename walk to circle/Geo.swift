//
//  Geo.swift
//  walk to circle
//
//  Helper methods for geo location calculations
//
//  Created by Evgenii Neumerzhitckii on 19/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Geo {
  func degreesToRadians(degrees: Double) -> Double {
    return (degrees / 180) * M_PI
  }

  func radiansToDegrees(radians: Double) -> Double {
    return radians * 180 / M_PI
  }

  /*
    Calculates destination point given distance and bearing from start point.
  
    Formula:
  
      φ2 = asin( sin φ1 ⋅ cos δ + cos φ1 ⋅ sin δ ⋅ cos θ )
      λ2 = λ1 + atan2( sin θ ⋅ sin δ ⋅ cos φ1, cos δ − sin φ1 ⋅ sin φ2 )
  
      Where:
        φ is latitude,
        λ is longitude,
        θ is the bearing (in radians, clockwise from north),
        δ is the angular distance (in radians) d/R;
        d being the distance travelled,
        R the earth’s radius
  
    Source: http://www.movable-type.co.uk/scripts/latlong.html
  */
  func destination(
    start: CLLocationCoordinate2D,
    distanceKm: Double,
    bearingDegrees: Double) -> CLLocationCoordinate2D {

    let φ1 = degreesToRadians(start.latitude)
    let λ1 = degreesToRadians(start.longitude)

    let θ = degreesToRadians(bearingDegrees)
    let R = 6_371.0; // Earth mean radius
    let δ = distanceKm / R

    let φ2 = asin( sin(φ1) * cos(δ) + cos(φ1) * sin(δ) * cos(θ) )
    let λ2 = λ1 + atan2( sin(θ) * sin(δ) * cos(φ1), cos(δ) - sin(φ1) * sin(φ2) )

    return CLLocationCoordinate2DMake(radiansToDegrees(φ2), radiansToDegrees(λ2));
  }

  /* Returns random value between min and max */
  func randomBetween(#min: Double, max: Double) -> Double {
    return min + drand48() * (max - min)
  }

  /* Returns random bearing between 0 and 360 degress */
  func randomBearinDegrees() -> Double {
    var min = 0.0
    var max = 360.0

    return min + drand48() * (max - min)
  }

  /*
    Returns random coordinate
    which is between minDistanceKm and maxDistanceKm from the start point.
  */
  func randomCoordinate(start: CLLocationCoordinate2D,
    minDistanceKm: Double,
    maxDistanceKm: Double) -> CLLocationCoordinate2D {

    var geo = Geo()

    var distanceKm = geo.randomBetween(min: minDistanceKm, max: maxDistanceKm)
    var bearingDegrees = geo.randomBearinDegrees()

    return geo.destination(start, distanceKm: distanceKm,
      bearingDegrees: bearingDegrees)
  }

  func regionForCoordinates(coords: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
    var mapRect = MKMapRectNull;
    for coord in coords {
      var mapPoint = MKMapPointForCoordinate(coord)

      var pointMapRect = MKMapRect(origin: mapPoint,
        size: MKMapSize(width: 0, height: 0))

      mapRect = MKMapRectUnion(mapRect, pointMapRect)
    }
    return MKCoordinateRegionForMapRect(mapRect)
  }

  func mapRectWidthInMeters(rect: MKMapRect) -> Double {
    var eastMapPoint = MKMapPointMake(MKMapRectGetMinX(rect), MKMapRectGetMidY(rect))
    var westMapPoint = MKMapPointMake(MKMapRectGetMaxX(rect), MKMapRectGetMidY(rect))

    return MKMetersBetweenMapPoints(eastMapPoint, westMapPoint)
  }
}