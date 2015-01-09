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

class iiGeo {
  class func degreesToRadians(degrees: Double) -> Double {
    return (degrees / 180) * M_PI
  }

  class func radiansToDegrees(radians: Double) -> Double {
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
  class func destination(
    start: CLLocationCoordinate2D,
    distanceMeters: Double,
    bearingDegrees: Double) -> CLLocationCoordinate2D {

    let φ1 = degreesToRadians(start.latitude)
    let λ1 = degreesToRadians(start.longitude)

    let θ = degreesToRadians(bearingDegrees)
    let R = 6_371_000.0; // Earth mean radius
    let δ = distanceMeters / R

    let φ2 = asin( sin(φ1) * cos(δ) + cos(φ1) * sin(δ) * cos(θ) )
    let λ2 = λ1 + atan2( sin(θ) * sin(δ) * cos(φ1), cos(δ) - sin(φ1) * sin(φ2) )

    return CLLocationCoordinate2DMake(radiansToDegrees(φ2), radiansToDegrees(λ2));
  }

  /* Returns random value between min and max */
  class func randomBetween(#min: Double, max: Double) -> Double {
    return min + iiRandom.randomBetween0And1 * (max - min)
  }

  /* Returns random bearing between 0 and 360 degress */
  class func randomBearinDegrees() -> Double {
    let min = 0.0
    let max = 360.0

    return min + iiRandom.randomBetween0And1 * (max - min)
  }

  /*
    Returns random coordinate
    which is between minDistanceMeters and maxDistanceMeters from the start point.
  */
  class func randomCoordinate(start: CLLocationCoordinate2D,
    minDistanceMeters: Double,
    maxDistanceMeters: Double) -> CLLocationCoordinate2D {

    var minDistanceMetersCorrected = minDistanceMeters
    var maxDistanceMetersCorrected = maxDistanceMeters

    // Correct the distance by 0.25%.
    // That is amount of inaccuracy in distance calculation.
    // We want to make sure the returned coordinate is always inside min/max range.
    if minDistanceMetersCorrected != maxDistanceMetersCorrected {
      minDistanceMetersCorrected += minDistanceMetersCorrected * 0.0025
      maxDistanceMetersCorrected -= maxDistanceMetersCorrected * 0.0025
    }

    if minDistanceMetersCorrected > maxDistanceMetersCorrected {
      minDistanceMetersCorrected = maxDistanceMetersCorrected
    }

    let distanceMeters = iiGeo.randomBetween(
      min: minDistanceMetersCorrected,
      max: maxDistanceMetersCorrected)

    let bearingDegrees = iiGeo.randomBearinDegrees()

    return iiGeo.destination(start, distanceMeters: distanceMeters,
      bearingDegrees: bearingDegrees)
  }

  class func mapSizeInMeters(rect: MKMapRect) -> CGSize {
    let eastMapPoint = MKMapPointMake(MKMapRectGetMinX(rect), MKMapRectGetMidY(rect))
    let westMapPoint = MKMapPointMake(MKMapRectGetMaxX(rect), MKMapRectGetMidY(rect))

    let northMapPoint = MKMapPointMake(MKMapRectGetMidX(rect), MKMapRectGetMinY(rect))
    let southMapPoint = MKMapPointMake(MKMapRectGetMidX(rect), MKMapRectGetMaxY(rect))

    return CGSize(
      width: MKMetersBetweenMapPoints(eastMapPoint, westMapPoint),
      height: MKMetersBetweenMapPoints(northMapPoint, southMapPoint))
  }

  /*
    Returns initial bearing in degrees from 0° to 360°
    which if followed in a straight line
    along a great-circle arc will take you from the start point to the end point.


    Formula:
  
      θ = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
  
    Where:
      φ is latitude,
      λ is longitude,
      θ is the bearing (in radians, clockwise from north),
      Δλ =  λ2 - λ1
  
    Since atan2 returns values in the range -π ... +π (that is, -180° ... +180°),
    to normalise the result to a compass bearing (in the range 0° ... 360°,
    with −ve values transformed into the range 180° ... 360°),
    convert to degrees and then use (θ+360) % 360,
    where % is (floating point) modulo.

    Source: http://www.movable-type.co.uk/scripts/latlong.html
  */
  class func initialBearing(#start: CLLocationCoordinate2D,
    end: CLLocationCoordinate2D) -> Double {

    var φ1 = degreesToRadians(start.latitude)
    var φ2 = degreesToRadians(end.latitude)

    var λ1 = degreesToRadians(start.longitude)
    var λ2 = degreesToRadians(end.longitude)

    let Δλ = λ2 - λ1

    let θ = atan2( sin(Δλ) * cos(φ2),
                   cos(φ1) * sin(φ2) - sin(φ1) * cos(φ2) * cos(Δλ))

    return (radiansToDegrees(θ) + 360) % 360
  }
}