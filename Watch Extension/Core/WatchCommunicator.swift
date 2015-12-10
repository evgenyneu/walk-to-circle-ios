import WatchKit
import WatchConnectivity

let walkWatchCommunicator = WatchCommunicator()

class WatchCommunicator: NSObject, WCSessionDelegate {
  
  var didUpdateStatusStart: (()->())?
  var didUpdateStatusCompass: (()->())?
  var didUpdateStatusDiagnose: (()->())?
  
  var didUpdateDirectionMainQueue: ((Int)->())?
  var didUpdateDirectionDiagnoseMainQueue: ((Int)->())?

  
  var status: String {
    get {
      return statusValues.joinWithSeparator(" ")
    }
  }
  
  /// True if iPhone is reachable.
  static var isReachable: Bool {
    return WCSession.defaultSession().reachable
  }
  
  /// True if the user has dropped the circle.
  static var isWalking: Bool {
    return true
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
      self?.didUpdateStatusStart?()
      self?.didUpdateStatusCompass?()
      self?.didUpdateStatusDiagnose?()
    }
  }
  
  func session(session: WCSession,
    didReceiveApplicationContext applicationContext: [String : AnyObject]) {
      
    iiQ.main { [weak self] in
      if let direction = applicationContext[WalkConstants.watch.replyKeys.walkDirection] as? Int {
        self?.didUpdateDirectionMainQueue?(direction)
        self?.didUpdateDirectionDiagnoseMainQueue?(direction)
      }
    }
  }
}