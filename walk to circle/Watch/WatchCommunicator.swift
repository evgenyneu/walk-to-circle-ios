import Foundation
import WatchConnectivity

var walkWatchCommunicator = WatchCommunicator()

class WatchCommunicator: NSObject, WCSessionDelegate {
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
      
    print("Reply to watch \(WatchParentReplyInfo.data)")
    replyHandler(WatchParentReplyInfo.data)
  }
}