import WatchKit
import Foundation
import WatchConnectivity

class DiagnoseInterfaceController: WKInterfaceController {
  
  @IBOutlet var walkLabel: WKInterfaceLabel!
  
  @IBOutlet var connectivityStatusLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    walkWatchCommunicator.didUpdateDirectionDiagnose = didUpdateDirection
    walkWatchCommunicator.didUpdateStatusDiagnose = updateConnectivityStatus
  }
  
  override func willActivate() {
    super.willActivate()
  
    didUpdateDirection()
    updateConnectivityStatus()
  }
  
  func didUpdateDirection() {
    let direction = walkWatchCommunicator.lastWalkingDirection
    walkLabel.setText("\(direction) \(timeTicks)")
  }
  
  func updateConnectivityStatus() {
    connectivityStatusLabel.setText("\(walkWatchCommunicator.status) \(timeTicks)")
  }
  
  var timeTicks: Double {
    return NSDate().timeIntervalSince1970 * 1000
  }
}