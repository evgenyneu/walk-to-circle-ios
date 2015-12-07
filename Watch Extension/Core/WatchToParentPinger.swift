import WatchKit
import WatchConnectivity

let watchToParentPinger = WatchToParentPinger()

class WatchToParentPinger {
  var timer: AutoCancellingTimer?
  var didUpdateDirectionMainQueue: ((Int)->())?
  
  func start() {
    //timer = AutoCancellingTimer(interval: 1, repeats: true, callback: timerDidFired)
  }
  
  private func timerDidFired() {
    if !WCSession.isSupported() { return }

    let session = WCSession.defaultSession()

    //print("Send message from child")

    let data = [WalkConstants.watch.commandKeyName: WalkConstants.watch.commands.getInfo]
    
    session.sendMessage(data,
      replyHandler: { reply in
        iiQ.main { [weak self] in
           self?.didReceiveReplyFromContainerAppMainQueue(reply)
        }
      },
      errorHandler: { error in
        print("Error connecting to parent \(error.description)")
      }
    )
  }
  
  private func didReceiveReplyFromContainerAppMainQueue(data: [String : AnyObject]) {
    //print("Reply from parent \(data)")
    
    if let direction = data[WalkConstants.watch.replyKeys.walkDirection] as? Int {
      didUpdateDirectionMainQueue?(direction)
    }
  }
}
