import WatchKit
import Foundation

class WalkInterfaceController: WKInterfaceController {
  override func willActivate() {
    super.willActivate()
    
    print("Walk will activate")
  }
}