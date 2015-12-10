import WatchKit
import Foundation
import WatchConnectivity

class DiagnoseInterfaceController: WKInterfaceController {
  
  @IBOutlet var walkLabel: WKInterfaceLabel!
  
  @IBOutlet var connectivityStatusLabel: WKInterfaceLabel!
  
  override func willActivate() {
    super.willActivate()
  
    walkWatchCommunicator.didUpdateDirectionDiagnoseMainQueue = didUpdateDirection
    walkWatchCommunicator.didUpdateStatusDiagnose = updateConnectivityStatus
  }
  
  func didUpdateDirection(direction: Int) {
    walkLabel.setText("\(direction) \(timeTicks)")
  }
  
  func updateConnectivityStatus() {
    connectivityStatusLabel.setText("\(walkWatchCommunicator.status) \(timeTicks)")
  }
  
  var timeTicks: Double {
    return NSDate().timeIntervalSince1970 * 1000
  }
}