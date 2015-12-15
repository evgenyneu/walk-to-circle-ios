import UIKit

class iiLayer {
  class func centerInParent_withSizeOfParent(layer: CALayer, parentBounds: CGRect) {
    centerInParent(layer, parentBounds: parentBounds)
    layer.bounds = CGRect(x: 0, y: 0, width: parentBounds.width, height: parentBounds.height)
  }

  class func centerInParent(layer: CALayer, parentBounds: CGRect) {
    layer.position = CGPoint(
      x: parentBounds.width / 2,
      y: parentBounds.height / 2)
  }

  class func loadImage(inLayer layer: CALayer, imageName: String) {
    if let uiImage = UIImage(named: imageName) {
      layer.contents = uiImage.CGImage
      layer.contentsScale = UIScreen.mainScreen().scale
    }
  }
}
