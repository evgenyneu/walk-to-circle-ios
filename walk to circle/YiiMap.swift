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

  // true after user locatino is visible with correct zoom
  private var mapIsReadyToStartTheGame = false
  
  private var didShowUserLocation = false

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
    didShowUserLocation = false
  }

  func applicationWillResignActive(notification: NSNotification) {
    Annotations.clearForBackground(mapView)
  }

  // Runs once when app if first started.
  // Scrolls/zooms map to show user location.
  private func showUserLocation() {
    if didShowUserLocation { return }

    ShowUserLocationOnMap.showUserLocation(mapView) {

      if !self.mapIsReadyToStartTheGame {
        self.delegate?.yiiMapDelegate_mapIsReady()
      }

      self.didShowUserLocation = true
      self.mapIsReadyToStartTheGame = true
    }
  }

  func dropNewPin() -> CLLocationCoordinate2D {
    Annotations.remove(mapView)

    let coordinate = iiGeo.randomCoordinate(mapView.userLocation.coordinate,
      minDistanceMeters: WalkConstants.minCircleDistanceFromCurrentLocationMeters,
      maxDistanceMeters: WalkConstants.maxCircleDistanceFromCurrentLocationMeters)

    if ShowUserLocationOnMap.needZoomingBeforePlay(mapView) {
      doAfterRegionDidChange {
        iiQ.runAfterDelay(0.3) {
          self.placePin(coordinate)
        }
      }

      ShowUserLocationOnMap.showUserLocation(mapView, userLocation: mapView.userLocation, animated: true)
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
    showUserLocation()
  }

  public func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
    callbackAfterRegionDidChange?()
    callbackAfterRegionDidChange = nil
  }
}
