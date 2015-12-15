import UIKit

class iiOsVersion {
  class var version: Float {
    return (UIDevice.currentDevice().systemVersion as NSString).floatValue
  }
}
