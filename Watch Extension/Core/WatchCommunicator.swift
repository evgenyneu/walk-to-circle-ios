import WatchKit
import WatchConnectivity

let walkWatchCommunicator = WatchCommunicator()

class WatchCommunicator: NSObject, WCSessionDelegate {
  
  var didUpdateStatusMainQueue: (()->())?
  var didUpdateDirectionMainQueue: ((Int)->())?
  
  var status: String {
    get {
      return statusValues.joinWithSeparator(" ")
    }
  }
  
  var statusValues: [String] = []
  
  func activateWatchConnectivity() {
    if !WCSession.isSupported() {
      iiQ.main { [weak self] in
        self?.statusValues.append("Not supported")
      }
      return
    }
    
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    
    iiQ.main { [weak self] in
      self?.statusValues.append("Activated")
    }
  }
  
  // MARK: - WCSessionDelegate
  
  func sessionReachabilityDidChange(session: WCSession) {
    statusValues = []
    
    if session.reachable {
      statusValues.append("Reachable")
    } else {
      statusValues.append("Unreachable")
    }
    
    if session.iOSDeviceNeedsUnlockAfterRebootForReachability {
      statusValues.append("Unlock")
    }
    
    iiQ.main { [weak self] in
      self?.didUpdateStatusMainQueue?()
    }
  }
  
  func session(session: WCSession,
    didReceiveApplicationContext applicationContext: [String : AnyObject]) {
      
    iiQ.main { [weak self] in
      if let direction = applicationContext[WalkConstants.watch.replyKeys.walkDirection] as? Int {
        self?.didUpdateDirectionMainQueue?(direction)
      } else {
        self?.didUpdateDirectionMainQueue?(-34)
      }
    }
  }
}