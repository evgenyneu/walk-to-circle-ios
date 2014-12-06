//
//  Show map where user drops a pin.
//
//  Created by Evgenii Neumerzhitckii on 23/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class YiiMap: NSObject, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!

  weak var delegate: YiiMapDelegate?

  private var annotations: Annotations!
  private var callbackAfterRegionDidChange: (()->())?

  private var zoomedToInitialLocation = false
  private var pindDropHeight: CGFloat = 0

  func viewDidLoad() {
    annotations = Annotations(mapView)

    mapView.delegate = self
    mapView.showsUserLocation = true
  }

  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.delegate?.yiiMapDelegate_mapIsReady()
    }
  }

  func placeCircleOnMap() {
    annotations.removeAll()

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceKm: 1, maxDistanceKm: 3)

    if InitialMapZoom.needZoomingBeforePlay(mapView) {
      doAfterRegionDidChange {
        iiQ.runAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      InitialMapZoom.zoomToLocation(mapView, userLocation: mapView.userLocation, animated: true)
    } else {
      self.placePin(coordinate)
    }
  }

  private func placePin(coordinate: CLLocationCoordinate2D) {
    if let startButtonView = delegate?.yiiMapDelegate_startButton {
      let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
        startButton: startButtonView, willDropAt: coordinate)

      let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
      pindDropHeight =  coordinateInView.y - scrollNeeded.height

      ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
        DropPin.placeCircleOnMapAndAnimate(self.mapView, coordinate: coordinate,
          annotations: self.annotations)
      }
    }
  }

  private func doAfterRegionDidChange(callback: ()->()) {
    callbackAfterRegionDidChange = callback
  }
}

// MapView Delegate
// ------------------------------

typealias MKMapViewDelegateImplementation = YiiMap

extension MKMapViewDelegateImplementation {
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    zoomToInitialLocation()
  }

  func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }

  func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
    DropPin.playPinDropSound(pindDropHeight)
  }
}
