import WatchKit

class HelpInterfaceController: WKInterfaceController {
  
  @IBOutlet var messageLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToHelpTab:",
      name: WalkConstants.watch.switchToHelpTab, object: nil)
  }
  
  override func didAppear() {
    super.didAppear()
    
    var text = WatchCommunicator.isWalking ?
      WalkConstants.watch.helpMessages.compassWalkInstruction:
      WalkConstants.watch.helpMessages.compassStartInstruction
    
    if !WatchCommunicator.isReachable {
      text = WalkConstants.watch.helpMessages.iPhoneUnreachable
    }
    
    messageLabel.setText(text)

  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: WalkConstants.watch.switchToHelpTab, object: nil)
  }
  
  func switchToHelpTab(notification: NSNotification) {
    becomeCurrentPage()
  }
}
