import Foundation
import CoreLocation

struct WalkCoordinateUserDefaultsSerializer {
  static func value(latitudeName: WalkUserDefaults, longitudeName: WalkUserDefaults)
    -> CLLocationCoordinate2D? {
      
    if let currentLatitude = latitudeName.value as? CLLocationDegrees {
      if let currentLongitude = longitudeName.value as? CLLocationDegrees {
        return CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
      }
    }
    
    return nil
  }

  static func save(newValue: CLLocationCoordinate2D?,
    latitudeName: WalkUserDefaults, longitudeName: WalkUserDefaults) {

    if let currentLocation = newValue {
      latitudeName.save(currentLocation.latitude)
      longitudeName.save(currentLocation.longitude)
    } else {
      // remove
      latitudeName.save(nil)
      longitudeName.save(nil)
    }
  }
}