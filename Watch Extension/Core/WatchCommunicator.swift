import WatchKit
import WatchConnectivity

class WatchCommunicator: NSObject, WCSessionDelegate {
  func activateWatchConnectivity() {
    if WCSession.isSupported() {
      let session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
    }
  }
}