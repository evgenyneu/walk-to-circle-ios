import WatchKit
import WatchConnectivity

class WatchCommunicator: NSObject, WCSessionDelegate {
  func activateWatchConnectivity() {
    if !WCSession.isSupported() { return }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
  }
}