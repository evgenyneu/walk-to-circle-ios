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
  public static let quotesJsonFileName = "Quotes.json"
  public static let mapCountdownIntervalSeconds = 5

  // Top margin above the quotes
  public static let quotesTopMargin: CGFloat = 110

  // No top margin when in landscape and screen height is small (phones in landscape)
  public static let quotesTopMarginCompact: CGFloat = 20

  public static let maxNumberOfLocationsToProcessInSingleLocationUpdate = 100

  // Stop location updates after this period to preserve battery
  public static let maxLocationUpdatePeriodSeconds: NSTimeInterval = 60 * 60

  public static let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Sound

  public static let regionCircleRadiusMeters = CLLocationDistance(100)

  public static let tutorialText = "Walk to the circle that was shown on the map. You will be notified when you reach it. You can lock your device during your walk. Just be careful on the street."

  public static let tutorialAuthor = "Evgenii Neumerzhitckii"  
}