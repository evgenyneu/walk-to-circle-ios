import Foundation
import CoreLocation
import MapKit

private weak var walkAnnotation: Annotation?

class Annotations {
  class func show(coordinate: CLLocationCoordinate2D, title: String,
    newPin: Bool, mapView: MKMapView) -> Annotation {

    remove(mapView)

    let annotation = Annotation(centerCoordinate: coordinate,
      radius: WalkConstants.regionCircleRadiusMeters - 5)

    walkAnnotation = annotation

    annotation.newPin = newPin
    
    annotation.title = title

    mapView.addAnnotation(annotation)
    mapView.addOverlay(annotation)

    return annotation
  }

  class func remove(mapView: MKMapView) {
    if let currentAnnotation = walkAnnotation {
      mapView.removeAnnotation(currentAnnotation)
      mapView.removeOverlay(currentAnnotation)
      walkAnnotation = nil
    }
  }

  // Function is called before app is going into background.
  // Out task is to remove the new pin and overlay from the map.
  // So it does not appear in task switcher.
  class func clearForBackground(mapView: MKMapView) {
    if let currentAnnotation = walkAnnotation {
      if !currentAnnotation.newPin { return } // We can leave the previous pin on the map

      remove(mapView)
    }
  }
}
