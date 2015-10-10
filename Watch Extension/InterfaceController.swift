

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  private var timer: NSTimer?
  
  private var toggleImage = true

  @IBOutlet var imageGroup: WKInterfaceGroup!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }
  
  override func willActivate() {
    super.willActivate()
    
    print("willActivate")
    
    startTimer()
  }
  
  deinit {
    print("deinit")
  }
  
  override func didDeactivate() {
    super.didDeactivate()
    
    print("didDeactivate")

    
    stopTimer()
  }
  
  override func didAppear() {
    super.didAppear()
    
    print("didAppear")
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
    imageGroup.setAlpha(toggleImage ? 0: 1)
    
    animateWithDuration(2) { [weak self] in
      if let thisSelf = self {
        thisSelf.imageGroup.setAlpha(thisSelf.toggleImage ? 1: 0)
      }
    }
  }
}
