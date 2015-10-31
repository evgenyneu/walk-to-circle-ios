import WatchKit
import WatchConnectivity

let watchToParentPinger = WatchToParentPinger()

class WatchToParentPinger {
  var timer: AutoCancellingTimer?
  
  func start() {
    timer = AutoCancellingTimer(interval: 1, repeats: true, callback: timerDidFired)
  }
  
  private func timerDidFired() {
    if !WCSession.isSupported() { return }

    let session = WCSession.defaultSession()

    print("Send message from child")

    let data = [WalkConstants.watch.commandKeyName: WalkConstants.watch.commands.getInfo]
    
    session.sendMessage(data, replyHandler: { reply in
      print("Reply from parent \(reply)")

      if let reply = reply as? [String: String] {
      }
    }, errorHandler: nil)
  }
}
