//
//  Show map where user drops a pin.
//
//  Created by Evgenii Neumerzhitckii on 23/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

public class YiiMap: NSObject, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!

  weak var delegate: YiiMapDelegate?

  private var callbackAfterRegionDidChange: (()->())?

  private var zoomedToInitialLocation = false

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: UIApplicationWillEnterForegroundNotification, object: nil)

    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: UIApplicationWillResignActiveNotification, object: nil)
  }

  func viewDidLoad() {
    mapView.delegate = self
    mapView.showsUserLocation = true

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:",
      name: UIApplicationWillEnterForegroundNotification, object: nil)

    NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:",
      name: UIApplicationWillResignActiveNotification, object: nil)
  }

  func applicationWillEnterForeground(notification: NSNotification) {
    // Make sure user location is visible on map when application enters foreground
    makeUserLocationVisible()
  }

  func applicationWillResignActive(notification: NSNotification) {
    Annotations.clearForBackground(mapView)
  }

  // Runs once when app if first started
  // Scrolls/zooms map to show user location
  private func zoomToInitialLocation() {
    if zoomedToInitialLocation { return }

    InitialMapZoom.zoomToInitialLocation(mapView) {
      self.zoomedToInitialLocation = true
      self.delegate?.yiiMapDelegate_mapIsReady()
    }
  }

  // Runs every time the app ener foreground
  // Scrolls/zooms map on user location if it is not visible on map
  private func makeUserLocationVisible() {
    if !zoomedToInitialLocation { return }

    InitialMapZoom.makeUserLocationVisible(mapView)
  }

  func dropNewPin() -> CLLocationCoordinate2D {
    Annotations.remove(mapView)

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceMeters: WalkConstants.minCircleDistanceFromCurrentLocationMeters,
      maxDistanceMeters: WalkConstants.maxCircleDistanceFromCurrentLocationMeters)

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
    return coordinate
  }

  func showPreviousPin(coordinate: CLLocationCoordinate2D) {
    DropPin.showPreviousPin(mapView, coordinate: coordinate)
  }

  private func placePin(coordinate: CLLocationCoordinate2D) {
    if let startButtonView = delegate?.yiiMapDelegate_startButton {
      let scrollNeeded = ScrollToAnnotation.scrollNeededToSeeAnnotation(mapView,
        startButton: startButtonView, willDropAt: coordinate)

      let coordinateInView = mapView.convertCoordinate(coordinate, toPointToView: mapView)
      let pinDropHeight =  coordinateInView.y - scrollNeeded.height

      ScrollToAnnotation.scrollMap(scrollNeeded, mapView: mapView) {
        DropPin.dropNewPinAndAnimate(self.mapView, coordinate: coordinate)
        DropPin.playPinDropSound(pinDropHeight)
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
  public func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    zoomToInitialLocation()
  }

  public func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }
}
