import WatchKit
import Foundation
import WatchConnectivity


class StartInterfaceController: WKInterfaceController {
  
  private var timer: NSTimer?
  
  private var toggleImage = true

  @IBOutlet var walkImage: WKInterfaceImage!
  @IBOutlet var stopImage: WKInterfaceImage!
  
  @IBOutlet var tapToWalkLabel: WKInterfaceLabel!
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    stopImage.setHeight(0)
  }
  
  override func willActivate() {
    super.willActivate()

    startTimer()
  }
  
  override func didDeactivate() {
    super.didDeactivate()
    
    stopTimer()
  }
  
  @IBAction func didTapStartButton() {
    animateWithDuration(0.5) { [weak self] in
      if let thisSelf = self {
        thisSelf.walkImage.setHeight(0)
        thisSelf.tapToWalkLabel.setHeight(0)
        thisSelf.stopImage.setHeight(100)
      }
    }
    //WalkInterfaceControllers.Walk.push(self)
    // startSession()
  }
  
  @IBAction func didTapStopButton() {
    animateWithDuration(0.5) { [weak self] in
      if let thisSelf = self {
        thisSelf.walkImage.setHeight(100)
        thisSelf.tapToWalkLabel.setHeight(15)
        thisSelf.stopImage.setHeight(0)
      }
    }
  }
  
  func startSession() {
    if !WCSession.isSupported() { return }
    
    let session = WCSession.defaultSession()
    
    print("Send message from child")
    
    session.sendMessage(["hoy":"drop circle"], replyHandler: { reply in
      print("Reply from parent \(reply)")
      
      if let reply = reply as? [String: String] {
      }
    }, errorHandler: nil)
  }
  
  private func startTimer() {
    stopTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(2,
      target: self, selector: "timerFired:", userInfo: nil, repeats: true)
  }
  
  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  func timerFired(timer: NSTimer) {
    animate()
  }
  
  private func animate() {
    toggleImage = !toggleImage
    //image.setAlpha(toggleImage ? 0: 1)
    
    animateWithDuration(2) { [weak self] in
      if let thisSelf = self {
        thisSelf.walkImage.setAlpha(thisSelf.toggleImage ? 1: 0)
      }
    }
  }
}
