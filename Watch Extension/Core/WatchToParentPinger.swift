import WatchKit
import WatchConnectivity

let watchToParentPinger = WatchToParentPinger()

class WatchToParentPinger {
  var timer: AutoCancellingTimer?
  var didUpdateDirection: ((Int)->())?
  
  func start() {
    timer = AutoCancellingTimer(interval: 1, repeats: true, callback: timerDidFired)
  }
  
  private func timerDidFired() {
    if !WCSession.isSupported() { return }

    let session = WCSession.defaultSession()

    print("Send message from child")

    let data = [WalkConstants.watch.commandKeyName: WalkConstants.watch.commands.getInfo]
    
    session.sendMessage(data,
    replyHandler: { [weak self] reply in
      print("Reply from parent \(reply)")
      self?.didUpdateDirection?(43512)

      if let direction = reply[WalkConstants.watch.replyKeys.walkDirection] as? Int {
        self?.didUpdateDirection?(direction)
      }
    },
    errorHandler: { error in
      print("Error connecting to parent \(error.description)")
    })
  }
}
