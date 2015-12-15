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
}



public struct WalkConstants_watch_userLocation {
  public let name = "userLocation"

  // Maximum age of current user location that is considered fresh, in seconds.
  public let maxLocationAgeInSeconds: NSTimeInterval = 30
}

