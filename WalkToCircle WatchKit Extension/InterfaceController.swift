//
//  Created by Evgenii Neumerzhitckii on 11/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  @IBOutlet weak var map: WKInterfaceMap!

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    // Configure interface objects here.
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()

    getDataFromParentApp()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

  private func getDataFromParentApp() {
    WKInterfaceController.openParentApplication(["asd":"asdas"]) { reply, error in

      println("Reply from parent \(reply)")

      if let currentReply = reply as? [String: AnyObject] {
        if let currentDirection = WalkWatchDataConsumer.fromDictionary(currentReply) {
          self.onReceivedDataFromParentApp(currentDirection)
        }
      }

    }
  }

  private func onReceivedDataFromParentApp(direction: WalkWatch_directionModel) {
    println("Direction: \(direction.circleDirection) coordinate: \(direction.userLocation.latitude),\(direction.userLocation.longitude)")
  }
}
