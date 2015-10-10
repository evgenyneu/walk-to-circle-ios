

import WatchKit
import Foundation


class StartInterfaceController: WKInterfaceController {
  
  private var timer: NSTimer?
  
  private var toggleImage = true

  @IBOutlet var image: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }
  
  override func willActivate() {
    super.willActivate()

    startTimer()
  }
  
  @IBAction func didTapWalkButton() {
  }
  
  override func didDeactivate() {
    super.didDeactivate()
    
    stopTimer()
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
        thisSelf.image.setAlpha(thisSelf.toggleImage ? 1: 0)
      }
    }
  }
}
