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

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    toggleMap(false)
  }

  override func willActivate() {
    super.willActivate()

    startTimer()
  }

  override func didDeactivate() {
    super.didDeactivate()

    stopTimer()
  }

  private func getDataFromParentApp() {
    WKInterfaceController.openParentApplication([:]) { reply, error in

      if let currentReply = reply as? [String: AnyObject] {
        if let currentDirection = WalkWatchDataConsumer.fromDictionary(currentReply) {
          self.didReceiveDirection(currentDirection)
          return
        }
      }

      self.toggleMap(false)
    }
  }

  private func didReceiveDirection(direction: WalkWatch_directionModel) {

    let coordinate = CLLocationCoordinate2D(
      latitude: direction.userLocation.latitude,
      longitude: direction.userLocation.longitude)

    let span = MKCoordinateSpan(
      latitudeDelta: WalkConstants.watch.mapSpan_inDegrees,
      longitudeDelta: WalkConstants.watch.mapSpan_inDegrees)

    if let currentPreviousMapCenter = previousMapCenter {
    }

    let region = MKCoordinateRegion(center: coordinate, span: span)

    map.setRegion(region)


    map.removeAllAnnotations()
    map.addAnnotation(coordinate,
      withImageNamed: "map_arrow_\(direction.circleDirection)", centerOffset: CGPointZero)

    toggleMap(true)
  }

  private func toggleMap(mapVisible: Bool) {
    mapGroup.setHidden(!mapVisible)
    arrowGroup.setHidden(mapVisible)
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
    let dateFormatter = NSDateFormatter()

    dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle

    let currentTime = dateFormatter.stringFromDate(NSDate())

    println("Timer fired \(currentTime)")


    getDataFromParentApp()
  }
}
