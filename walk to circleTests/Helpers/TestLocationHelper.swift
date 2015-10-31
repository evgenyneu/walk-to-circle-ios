import CoreLocation
@testable import WalkToCircle

struct TestLocationHelper {
  static func setTestUserLocation(coordinate: CLLocationCoordinate2D) {
    let location = CLLocation(
      coordinate: coordinate,
      altitude: 0,
      horizontalAccuracy: 0,
      verticalAccuracy: 0,
      course: 0,
      speed: 0,
      timestamp: NSDate())
    
    WalkLocation.shared.lastLocation = location
  }
}