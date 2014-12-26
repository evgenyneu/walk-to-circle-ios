//
//  iiCLErrorToString.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 27/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

struct iiCLErrorToString {
  static func toString(errorCode: Int) -> String {
    if let currentCLError = CLError(rawValue: errorCode) {
      return toString(currentCLError)
    }

    return "Invalid error code: \(errorCode)"
  }

  static func toString(error: CLError) -> String {
    switch error {
    case .LocationUnknown:
      return "location is currently unknown, but CL will keep trying"
    case .Denied:
      return "Access to location or ranging has been denied by the user"
    case .Network:
      return "General, network-related error"
    case .HeadingFailure:
      return "Heading could not be determined"
    case .RegionMonitoringDenied:
      return "Location region monitoring has been denied by the user"
    case .RegionMonitoringFailure:
      return "A registered region cannot be monitored"
    case .RegionMonitoringSetupDelayed:
      return "CL could not immediately initialize region monitoring"
    case .RegionMonitoringResponseDelayed:
      return "While events for this fence will be delivered, delivery will not occur immediately"
    case .GeocodeFoundNoResult:
      return "A geocode request yielded no result"
    case .GeocodeFoundPartialResult:
      return "A geocode request yielded a partial result"
    case .GeocodeCanceled:
      return "A geocode request was cancelled"
    case .DeferredFailed:
      return "Deferred mode failed"
    case .DeferredNotUpdatingLocation:
      return "Deferred mode failed because location updates disabled or paused"
    case .DeferredAccuracyTooLow:
      return "Deferred mode not supported for the requested accuracy"
    case .DeferredDistanceFiltered:
      return "Deferred mode does not support distance filters"
    case .DeferredCanceled:
      return "Deferred mode request canceled a previous request"
    case .RangingUnavailable:
      return "Ranging cannot be performed"
    case .RangingFailure:
      return "General ranging failure"
    default:
      return "Unknown error code: \(error.rawValue)"
    }
  }
}
