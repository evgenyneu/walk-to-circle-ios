import WatchKit
import Foundation
import WatchConnectivity

class WalkInterfaceController: WKInterfaceController {
  override func willActivate() {
    super.willActivate()
    
    startSession()
  }
  
  func startSession() {
    if !WCSession.isSupported() { return }
    
    let session = WCSession.defaultSession()
    
    print("Send message from child")
    
    session.sendMessage(["command":"drop circle"], replyHandler: { reply in
      print("Reply from parent \(reply)")

      if let reply = reply as? [String: String] {
      }
    }, errorHandler: nil)
  }
}