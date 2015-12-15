import UIKit

class iiAutolayoutConstraints {
  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""

    if margin != 0 {
      marginFormat = "-\(margin)-"
    }

    var format = "|\(marginFormat)[view]\(marginFormat)|"

    if vertically {
      format = "V:" + format
    }

    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: ["view": view])

    parentView.addConstraints(constraints)
  }

  class func height(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: NSLayoutAttribute.Height,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1,
      constant: value)
    
    view.addConstraint(constraint)
    
    return [constraint]
  }

  class func equalWidth(viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat("[viewOne(==viewTwo)]",
      options: NSLayoutFormatOptions(rawValue: 0), metrics: nil,
      views: ["viewOne": viewOne, "viewTwo": viewTwo]) as [NSLayoutConstraint]

    constraintContainer.addConstraints(constraints)

    return constraints
  }
}
