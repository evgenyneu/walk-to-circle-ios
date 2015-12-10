import WatchKit

class CompassInterfaceController: WKInterfaceController {

  @IBOutlet var arrowGroup: WKInterfaceGroup!
  
  @IBOutlet var noPhoneGroup: WKInterfaceGroup!
  
  override func willActivate() {
    super.willActivate()
    
    walkWatchCommunicator.didUpdateDirectionMainQueue = didUpdateDirection
    walkWatchCommunicator.didUpdateStatusCompass = didUpdateStatus
  }
  
  override func didAppear() {
    super.didAppear()
    didUpdateStatus()
  }
  
  func didUpdateDirection(direction: Int) {
    let imageName = arrowFileName(direction)
    arrowGroup.setBackgroundImageNamed(imageName)
  }
  
  func didUpdateStatus() {
    if WatchCommunicator.isReachable {
      noPhoneGroup.setBackgroundImage(nil)
    } else {
      noPhoneGroup.setBackgroundImageNamed(WalkConstants.watch.images.noPhone)
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
