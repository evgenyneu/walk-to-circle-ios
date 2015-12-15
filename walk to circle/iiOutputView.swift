import UIKit

class iiOutputView {
  class func show(text: String) {
    if let viewConctroller = UIApplication.sharedApplication().delegate?.window??.rootViewController as? MapViewController {
      viewConctroller.outputLabel.text = text
      viewConctroller.outputLabel.hidden = false
    }
  }
}


protocol iiOutputViewController {
  weak var outputLabel: UILabel! { get }
}