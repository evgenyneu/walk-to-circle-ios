import WatchKit
import WatchConnectivity

class WatchToParentPinger {
  var timer: AutoCancellingTimer?
  
  func start() {
    timer = AutoCancellingTimer(interval: 1, repeats: true, callback: timerDidFired)
  }
  
  private func timerDidFired() {
    if !WCSession.isSupported() { return }

    let session = WCSession.defaultSession()

    print("Send message from child")

    session.sendMessage(["command":"drop circle"], replyHandler: { reply in
      print("Reply from parent \(reply)")

      if let reply = reply as? [String: String] {
      }
    }, errorHandler: nil)
  }
}
