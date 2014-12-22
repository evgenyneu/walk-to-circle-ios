//
//  Collection of shortcuts to create autolayout constraints.
//
//  Created by Evgenii Neumerzhitckii on 27/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiAutolayoutConstraints {
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
}
