import UIKit
import CoreLocation

let iiWalkLocation = WalkLocation()

public class WalkLocation: NSObject, CLLocationManagerDelegate {
  private let locationManager = CLLocationManager()
  private var locationUpdateStarted: NSDate?
  public var lastLocation: CLLocation?

  public class var shared: WalkLocation {
    return iiWalkLocation
  }

  private override init() {
    super.init()
    locationManager.delegate = self
  }

  func reactToCurrentAuthorizationStatus() {
    checkAuthorizationStatus(CLLocationManager.authorizationStatus())
  }

  func checkAuthorizationStatus(status: CLAuthorizationStatus) {
    switch status {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      WalkViewControllers.nonErrorToBePresented.show()
      
    case .Denied, .Restricted:
      WalkViewControllers.LocationDenied.show()
      
    case .NotDetermined:
      if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
        locationManager.requestAlwaysAuthorization()
      }
    }
  }

  func startUpdatingLocation() {
    stopUpdatingLocation()

    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.pausesLocationUpdatesAutomatically = false

    locationManager.startUpdatingLocation()
    locationUpdateStarted = NSDate()
    
    if #available(iOS 9.0, *) {
      locationManager.allowsBackgroundLocationUpdates = true
    }
  }

  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    locationUpdateStarted = nil
  }
}

// CLLocationManagerDelegate
// ------------------------------

typealias WalkLocation_LocationManagerDelegate_Implementation = WalkLocation

extension WalkLocation_LocationManagerDelegate_Implementation {

  public func locationManager(manager: CLLocationManager,
    didChangeAuthorizationStatus status: CLAuthorizationStatus) {

    checkAuthorizationStatus(status)
  }

  public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if updatingLocationForTooLong {
      // The location updates were running for too long
      // User has probably abandoned the app.
      // Stop location updates to preserve the battery life.
      // Location updates will be restarted when/if the app is opened again.
      stopUpdatingLocation()
    }

    for (index, location) in locations.enumerate() {
      if index >= WalkConstants.maxNumberOfLocationsToProcessInSingleLocationUpdate { return }

      lastLocation = location
      if WalkCircleMonitor.shared.processLocationUpdate(location) { return }
    }
  }
  
  var updatingLocationForTooLong: Bool {
    if let currentLocateUpdateStartDate = locationUpdateStarted {
      let secondsUpdating = NSDate().timeIntervalSinceDate(currentLocateUpdateStartDate)
      return secondsUpdating > WalkConstants.maxLocationUpdatePeriodSeconds
    }

    return false
  }
}
