import WatchKit
import WatchConnectivity

let walkWatchCommunicator = WatchCommunicator()

class WatchCommunicator: NSObject, WCSessionDelegate {
  
  var didUpdateStatusStart: (()->())?
  var didUpdateStatusCompass: (()->())?
  var didUpdateStatusDiagnose: (()->())?
  
  var didUpdateDirectionStart: (()->())?
  var didUpdateDirectionCompass: (()->())?
  var didUpdateDirectionDiagnose: (()->())?
  
  var didUpdateStatusOrDirectionHelp: (()->())?
  
  var lastWalkingDirection: Int = WalkConstants.watch.walkDirectionUnkown
  
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
  var isWalking: Bool {
    return lastWalkingDirection != WalkConstants.watch.walkDirectionUnkown
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
      self?.didUpdateStatusOrDirectionHelp?()
    }
  }
  
  func session(session: WCSession,
    didReceiveApplicationContext applicationContext: [String : AnyObject]) {
      
    iiQ.main { [weak self] in
      if let direction = applicationContext[WalkConstants.watch.replyKeys.walkDirection] as? Int {
        self?.lastWalkingDirection = direction
        
        self?.didUpdateDirectionStart?()
        self?.didUpdateDirectionCompass?()
        self?.didUpdateDirectionDiagnose?()
        self?.didUpdateStatusOrDirectionHelp?()
      }
    }
  }
}