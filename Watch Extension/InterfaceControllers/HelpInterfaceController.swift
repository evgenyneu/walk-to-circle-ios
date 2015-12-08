import WatchKit

class HelpInterfaceController: WKInterfaceController {
  @IBOutlet var arrowImage: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchToHelpTab:",
      name: WalkConstants.watch.switchToHelpTab, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: WalkConstants.watch.switchToHelpTab, object: nil)
  }
  
  func switchToHelpTab(notification: NSNotification) {
    becomeCurrentPage()
  }
}
