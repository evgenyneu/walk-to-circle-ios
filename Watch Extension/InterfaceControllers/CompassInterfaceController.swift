import WatchKit

class CompassInterfaceController: WKInterfaceController {
  @IBOutlet var arrowImage: WKInterfaceImage!

  override func willActivate() {
    super.willActivate()
    
    walkWatchCommunicator.didUpdateDirectionMainQueue = didUpdateDirectionMainQueue
  }
  
  func didUpdateDirectionMainQueue(direction: Int) {
    //let imageName = arrowFileName(direction)
    //arrowImage.setImageNamed(imageName)
  }
  
  private func arrowFileName(direction: Int) -> String {
    return "compass_arrow_\(direction)"
  }
  
  @IBAction func didTapHelpButton() {
    NSNotificationCenter.defaultCenter().postNotificationName(WalkConstants.watch.switchToHelpTab,
      object: nil)
  }
}
