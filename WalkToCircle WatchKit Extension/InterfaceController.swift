//
//  Created by Evgenii Neumerzhitckii on 11/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  @IBOutlet weak var mapGroup: WKInterfaceGroup!
  @IBOutlet weak var arrowGroup: WKInterfaceGroup!
  @IBOutlet weak var map: WKInterfaceMap!

  private var timer: NSTimer?

  private var previousMapCenter: CLLocationCoordinate2D?
  private var previousDirection: Int?

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    toggleMap(false)
  }

  override func willActivate() {
    super.willActivate()

    getDataFromParentApp()
    startTimer()
  }

  override func didDeactivate() {
    super.didDeactivate()

    stopTimer()
  }

  private func getDataFromParentApp() {
//    WKInterfaceController.openParentApplication([:]) { reply, error in
//
//      if let currentReply = reply as? [String: AnyObject] {
//        if let currentDirection = WalkWatchDataConsumer.fromDictionary(currentReply) {
//          self.didReceiveDirection(currentDirection)
//          return
//        }
//      }
//
//      self.toggleMap(false)
//    }
  }

  // Map
  // --------------------

  private func didReceiveDirection(direction: WalkWatch_directionModel) {

    let coordinate = CLLocationCoordinate2D(
      latitude: direction.userLocation.latitude,
      longitude: direction.userLocation.longitude)

    setMapRegion(coordinate)

    updateMapAnnotation(coordinate, direction: direction)

    toggleMap(true)

    if coordinateChanged(coordinate) {
      previousMapCenter = coordinate
    }

    previousDirection = direction.circleDirection
  }

  private func setMapRegion(coordinate: CLLocationCoordinate2D) {

    if !coordinateChanged(coordinate) { return }

    let span = MKCoordinateSpan(
      latitudeDelta: WalkConstants.watch.mapSpan_inDegrees,
      longitudeDelta: WalkConstants.watch.mapSpan_inDegrees)

    let region = MKCoordinateRegion(center: coordinate, span: span)

    map.setRegion(region)
  }

  private func updateMapAnnotation(coordinate: CLLocationCoordinate2D,
    direction: WalkWatch_directionModel) {

    if !directionChanged(direction.circleDirection) && !coordinateChanged(coordinate) { return }

    map.removeAllAnnotations()

    let imageName = arrowImageName(direction.circleDirection)
    map.addAnnotation(coordinate, withImageNamed: imageName, centerOffset: CGPointZero)
  }

  private func toggleMap(mapVisible: Bool) {
    mapGroup.setHidden(!mapVisible)
    arrowGroup.setHidden(mapVisible)
  }

  private func arrowImageName(direction: Int) -> String {
    let paddedNumber = String(format: "%02d", direction)
    return "map_arrow_padded_\(paddedNumber)"
  }

  private func coordinateChanged(coordinate: CLLocationCoordinate2D) -> Bool {
    if let currentPreviousMapCenter = previousMapCenter {
      let distance = iiGeo.distanceInMeters(start: currentPreviousMapCenter, end: coordinate)

      return distance > WalkConstants.watch.minMapUpdateDistance_inMeters
    }

    return true
  }

  private func directionChanged(direction: Int) -> Bool {
    if let currentPreviousDirection = previousDirection {
      return currentPreviousDirection != direction
    }

    return true
  }

  // Timer
  // --------------

  private func startTimer() {
    stopTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(
      WalkConstants.watch.updateDirectionInterval_inSeconds,
      target: self, selector: "timerFired:", userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  func timerFired(timer: NSTimer) {
    getDataFromParentApp()
  }
}
