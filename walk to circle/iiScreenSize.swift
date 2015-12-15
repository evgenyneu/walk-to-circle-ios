import UIKit

let iiScreenSizeBounds = UIScreen.mainScreen().bounds

class iiScreenSize {
  class var minSide: CGFloat {
    let screenSize = iiScreenSizeBounds.size
    return min(screenSize.width, screenSize.height)
  }

  class var maxSide: CGFloat {
    let screenSize = iiScreenSizeBounds.size
    return max(screenSize.width, screenSize.height)
  }
}
