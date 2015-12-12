import WatchKit

class CompassInterfaceController: WKInterfaceController {

  @IBOutlet var arrowGroup: WKInterfaceGroup!
  
  @IBOutlet var noPhoneGroup: WKInterfaceGroup!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    walkWatchCommunicator.didUpdateDirectionCompass = didUpdateDirection
    walkWatchCommunicator.didUpdateStatusCompass = didUpdateStatus
  }
  
  override func willActivate() {
    super.willActivate()
    
    didUpdateDirection()
    didUpdateStatus()
  }
  
  func didUpdateStatus() {
    if WatchCommunicator.isReachable {
      noPhoneGroup.setBackgroundImage(nil)
    } else {
      noPhoneGroup.setBackgroundImageNamed(WalkConstants.watch.images.noPhone)
    }
  }
  
  func didUpdateDirection() {
    let direction = walkWatchCommunicator.lastWalkingDirection
    
    if direction == WalkConstants.watch.walkDirectionUnkown {
      arrowGroup.setBackgroundImage(nil)
    } else {
      let imageName = arrowFileName(direction)
      arrowGroup.setBackgroundImageNamed(imageName)
    }
  }
  
  private func arrowFileName(direction: Int) -> String {
    return "\(WalkConstants.watch.images.compassArrow)\(direction)"
  }
  
  @IBAction func didTapHelpButton() {
    NSNotificationCenter.defaultCenter().postNotificationName(WalkConstants.watch.switchToHelpTab,
      object: nil)
  }
}
