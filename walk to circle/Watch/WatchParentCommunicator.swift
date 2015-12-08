import Foundation
import WatchConnectivity

var walkWatchParentCommunicator = WatchParentCommunicator()

class WatchParentCommunicator: NSObject, WCSessionDelegate {
  func activateWatchConnectivity() {
    if #available(iOS 9.0, *) {
      if !WCSession.isSupported() { return }
      
      //print("Activate watch connectivity (parent)")
      let session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
      WalkCircleMonitor.shared.didReceiveLocationUpdateForWatch = didReceiveLocationUpdate
      
    }
  }
  
  private func didReceiveLocationUpdate() {
    if #available(iOS 9.0, *) {
      do {
        try WCSession.defaultSession().updateApplicationContext(WatchParentReplyInfo.data)
      } catch {
        print("Error updating context.")
      }
    }
  }
  
  // MARK: - WCSessionDelegate
  // ----------------
  
  @available(iOS 9.0, *)
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject],
    replyHandler: ([String : AnyObject]) -> Void) {
      
    iiQ.main {
      //print("Reply to watch \(WatchParentReplyInfo.data)")
      replyHandler(WatchParentReplyInfo.data)
    }
  }
}