import WatchKit
import Foundation
import WatchConnectivity

class StartInterfaceController: WKInterfaceController {
  
  @IBOutlet var noPhoneImage: WKInterfaceImage!
  @IBOutlet var buttonGroup: WKInterfaceGroup!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    walkWatchCommunicator.didUpdateDirectionStart = didUpdateDirection
    walkWatchCommunicator.didUpdateStatusStart = didUpdateStatus
  }
  
  override func willActivate() {
    super.willActivate()
    didUpdateDirection()
    didUpdateStatus()
  }
  
  func didUpdateDirection() {
    let buttonImage = walkWatchCommunicator.isWalking ? WalkConstants.watch.images.stopButton :
      WalkConstants.watch.images.startButton
        
    buttonGroup.setBackgroundImageNamed(buttonImage)
  }
  
  func didUpdateStatus() {
    if WatchCommunicator.isReachable {
      noPhoneImage.setImage(nil)
    } else {
      noPhoneImage.setImageNamed(WalkConstants.watch.images.noPhone)
    }
  }
  
  @IBAction func didTouchButton() {
  }
}
