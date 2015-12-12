import WatchKit
import Foundation
import WatchConnectivity

class StartInterfaceController: WKInterfaceController {
  
  @IBOutlet var noPhoneImage: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    walkWatchCommunicator.didUpdateStatusStart = didUpdateStatus
  }
  
  override func willActivate() {
    super.willActivate()
    didUpdateStatus()
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
