//
//  Created by Evgenii Neumerzhitckii on 14/03/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import WatchKit
import Foundation

class InfoInterfaceController: WKInterfaceController {

  private var timer: NSTimer?

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
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
//    WKInterfaceController.openParentApplication([:]) { reply, error in
//
//      if let currentReply = reply as? [String: AnyObject] {
//        if let currentDirection = WalkWatchDataConsumer.fromDictionary(currentReply) {
//          self.popToRootController()
//          return
//        }
//      }
//    }
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