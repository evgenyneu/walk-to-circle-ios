import Foundation
import WatchConnectivity

var walkWatchCommunicator = WatchCommunicator()

class WatchCommunicator: NSObject, WCSessionDelegate {
  static func reply(reply: (([String : AnyObject]) -> Void)) {
    let data = ["hi": "hello"]
    reply(data)
  }
  
  func activateWatchConnectivity() {
    if #available(iOS 9.0, *) {
      if !WCSession.isSupported() { return }
      
      print("Activate watch connectivity (parent)")
      let session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
    }
  }
  
  // MARK: - WCSessionDelegate
  // ----------------
  
  @available(iOS 9.0, *)
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject],
    replyHandler: ([String : AnyObject]) -> Void) {
      
    iiQ.main { WalkViewControllers.Congrats.show() }
    WatchCommunicator.reply(replyHandler)
    print("message from watch")
  }
}