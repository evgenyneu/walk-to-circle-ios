//
//  Geo.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation


/*
  Helper methods for geo location calculations
*/
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
    fromCoord: CLLocationCoordinate2D,
    distanceKm: Double,
    bearingDegrees: Double) -> CLLocationCoordinate2D {

    let φ1 = degreesToRadians(fromCoord.latitude)
    let λ1 = degreesToRadians(fromCoord.longitude)

    let θ = degreesToRadians(bearingDegrees)
    let R = 6_371.0; // Earth mean radius
    let δ = distanceKm / R

    let φ2 = asin( sin(φ1) * cos(δ) + cos(φ1) * sin(δ) * cos(θ) )
    let λ2 = λ1 + atan2( sin(θ) * sin(δ) * cos(φ1), cos(δ) - sin(φ1) * sin(φ2) )

    return CLLocationCoordinate2DMake(radiansToDegrees(φ2), radiansToDegrees(λ2));
  }
}