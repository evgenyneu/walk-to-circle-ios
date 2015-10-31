//
//  WalkConstants.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

public struct WalkConstants {
  public static let viewControllerTransitionDuration: NSTimeInterval = 1
  public static let showMapAnnotationAfterDelay: NSTimeInterval = 1
  public static let hideMapAnnotationAfterDelay: NSTimeInterval = 3

  public static let quotesJsonFileName = "Quotes.json"
  public static let mapCountdownIntervalSeconds = 5

  // Top margin above the quotes
  public static let quotesTopMargin: CGFloat = 110

  // No top margin when in landscape and screen height is small (phones in landscape)
  public static let quotesTopMarginCompact: CGFloat = 20

  public static let maxNumberOfLocationsToProcessInSingleLocationUpdate = 100

  // Stop location updates after this period of time to preserve battery
  public static let maxLocationUpdatePeriodSeconds: NSTimeInterval = 60 * 60

  public static let minCircleDistanceFromCurrentLocationMeters: CLLocationDistance = 300
  public static let maxCircleDistanceFromCurrentLocationMeters: CLLocationDistance = 500

  public static let regionCircleRadiusMeters = CLLocationDistance(90)

  public static let tutorialText = "Walk to the circle that was shown on the map. You will be notified when you reach it. Have a wonderful and safe walk."

  public static let tutorialAuthor = "Evgenii Neumerzhitckii"

  public static let textFadeInDuration = 3.0

  public static let watchOld = WalkConstants_watchOld()
  public static let watch = WalkConstants_watch()

}

public struct WalkConstants_watch {
  public let commandKeyName = "command"
  public let commands = WalkConstants_watchCommands()
  public let replyKeys = WalkConstants_watchReplyKeys()
  public let walkDirectionUnkown: Int = -9973
}

public struct WalkConstants_watchCommands {
  let start = "start"
  let stop = "stop"
  let getInfo = "get info"
}

public struct WalkConstants_watchReplyKeys {
  let walkDirection = "walk direction"
}

public struct WalkConstants_watchOld {
  public let userLocation = WalkConstants_watch_userLocation()
  public let circleDirectionName = "circleDirection"

  public let latitudeName = "latitude"
  public let longitudeName = "longitude"

  // Number of directions.
  // Directions go from 0 to (numberOfDirections-1).
  // The values represent direction angle from North moving clockwise.
  //
  // For example, if there are 4 directions, the values will be:
  //  0 - North
  //  1 - West
  //  2 - South
  //  3 - East
  public let numberOfDirections = 16

  public let updateDirectionInterval_inSeconds:NSTimeInterval = 2

  public let mapSpan_inDegrees: CLLocationDegrees = 0.004

  // Number of meters we need to travel in order to update the map on the watch
  public let minMapUpdateDistance_inMeters: CLLocationDistance = 30
}

public struct WalkConstants_watch_userLocation {
  public let name = "userLocation"

  // Maximum age of current user location that is considered fresh, in seconds.
  public let maxLocationAgeInSeconds: NSTimeInterval = 30
}
