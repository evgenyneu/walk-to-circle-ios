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
  public static let mapCountdownIntervalSeconds = 1

  // Top margin above the quotes
  public static let quotesTopMargin: CGFloat = 110

  // No top margin when in landscape and screen height is small (phones in landscape)
  public static let quotesTopMarginCompact: CGFloat = 20

  public static let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Sound

  public static let regionCircleRadiusMeters = CLLocationDistance(100)

  public static let tutorialText = "Walk to the circle that was shown on the map. You will be notified when you reach it. You can lock your device or use any other app while you walk."

  public static let tutorialAuthor = "Evgenii Neumerzhitckii"  
}