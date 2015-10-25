import WatchKit
import Foundation
import WatchConnectivity


class StartInterfaceController: WKInterfaceController {
  
  var walking = true
  @IBOutlet var group: WKInterfaceGroup!
  @IBOutlet var image: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }
  
  override func willActivate() {
    super.willActivate()

  }
  
  override func didDeactivate() {
    super.didDeactivate()
  }
  
  @IBAction func didTapButton() {
    let imageNew = walking ? "Watch_compass" : "Watch_walk"
    let imageOld = walking ?  "Watch_walk" : "Watch_compass"
    
    walking = !walking
    
    group.setBackgroundImageNamed(imageOld)
    image.setImageNamed(imageNew)
  }

}
