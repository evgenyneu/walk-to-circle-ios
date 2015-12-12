import WatchKit

class HelpInterfaceController: WKInterfaceController {
  
  @IBOutlet var messageLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToHelpTab:",
      name: WalkConstants.watch.switchToHelpTab, object: nil)
    
    walkWatchCommunicator.didUpdateStatusOrDirectionHelp = updateText
  }
  
  override func willActivate() {
    super.willActivate()
    updateText()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: WalkConstants.watch.switchToHelpTab, object: nil)
  }
  
  private func updateText() {
    var text = walkWatchCommunicator.isWalking ?
      WalkConstants.watch.helpMessages.compassWalkInstruction:
      WalkConstants.watch.helpMessages.compassStartInstruction
    
    if !WatchCommunicator.isReachable {
      text = WalkConstants.watch.helpMessages.iPhoneUnreachable
    }
    
    messageLabel.setText(text)
  }
  
  func switchToHelpTab(notification: NSNotification) {
    becomeCurrentPage()
  }
}
