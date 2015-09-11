//
//  Helper functions to deal with view positioning.
//
//  Created by Evgenii Neumerzhitckii on 23/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

let iiHidingConstraintIdentifier = "zero height constraint for hiding view"

class iiViewPosition {
  // Hides the view by making its height zero.
  //
  // It allows for other views that use autolayout constraints
  // in relation to this view to continue working
  //
  // For example, suppose we have views A and B.
  // View B is positioned below view A with an autolayout constraint. 
  // If we hide view A with this function view B will still be positioned correctly.
  class func hide(view: UIView) {
    unhide(view) // remove constraints for hiding

    view.hidden = true
    let constraints = iiAutolayoutConstraints.height(view, value: 0)

    for constraint in constraints {
      constraint.identifier = iiHidingConstraintIdentifier
    }
  }

  // Shows the view previously hidden with `hide` method
  class func unhide(view: UIView) {
    view.hidden = false
    for constraint in view.constraints {
      if constraint.identifier == iiHidingConstraintIdentifier {
        view.removeConstraint(constraint)
      }
    }
  }
}
