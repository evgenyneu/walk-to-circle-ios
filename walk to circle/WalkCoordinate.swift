import Foundation
import CoreLocation

public class WalkCoordinate {
  public class func clearCurrent() {
    if let currentUnwrapped = current {
      previous = currentUnwrapped // save current coordinate to previous to show on the map
    }

    current = nil
  }

  public class var current: CLLocationCoordinate2D? {
    get {
      return WalkCoordinateUserDefaultsSerializer.value(
        WalkUserDefaults.currentCircleCoordinateLatitude,
        longitudeName: WalkUserDefaults.currentCircleCoordinateLongitude)
    }

    set {
      WalkCoordinateUserDefaultsSerializer.save(newValue,
        latitudeName: WalkUserDefaults.currentCircleCoordinateLatitude,
        longitudeName: WalkUserDefaults.currentCircleCoordinateLongitude)
    }
  }

  public class var previous: CLLocationCoordinate2D? {
    get {
      return WalkCoordinateUserDefaultsSerializer.value(
        WalkUserDefaults.previousCircleCoordinateLatitude,
        longitudeName: WalkUserDefaults.previousCircleCoordinateLongitude)
    }

    set {
      WalkCoordinateUserDefaultsSerializer.save(newValue,
        latitudeName: WalkUserDefaults.previousCircleCoordinateLatitude,
        longitudeName: WalkUserDefaults.previousCircleCoordinateLongitude)
    }
  }
}

