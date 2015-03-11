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

  struct watchData {
    let userLocation: watchData_userLocation
    let circleDirection: Int
  }

  struct watchData_userLocation {
    let latitude: Double
    let longitude: Double
  }

  private func getDataFromParentApp() {
    WKInterfaceController.openParentApplication(["asd":"asdas"]) { reply, error in

      println("Reply from parent \(reply)")
      if reply == nil { return }

      let p = CutePossumParser(data: reply)

      let data = watchData(
        userLocation: watchData_userLocation(
          latitude: p["userLocation"].parse("latitude", miss: 0),
          longitude: p["userLocation"].parse("longitude", miss: 0)),
        circleDirection: p.parse("circleDirection", miss: 0)
      )

      if !p.success { return }

      self.onReceivedDataFromParentApp(data)

      println("Reply from parent app \(reply)")
    }
  }

  private func onReceivedDataFromParentApp(data: watchData) {
    println("Direction: \(data.circleDirection) coordinate: \(data.userLocation.latitude),\(data.userLocation.longitude)")
  }
}
