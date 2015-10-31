import WatchKit
import Foundation
import WatchConnectivity

class WalkInterfaceController: WKInterfaceController {
  
  @IBOutlet var walkLabel: WKInterfaceLabel!
  
  override func willActivate() {
    super.willActivate()
  
    watchToParentPinger.didUpdateDirection = didUpdateDirection
  }
  
  func didUpdateDirection(direction: Int) {
    iiQ.main { [weak self] in
      self?.walkLabel.setText("\(direction) \(NSDate().timeIntervalSince1970 * 1000)")
    }
  }
}