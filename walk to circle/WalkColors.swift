//
//  WalkColors.swift
//
//  Created by Evgenii Neumerzhitckii on 26/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

enum WalkColors: String {
  case NewPinOverlay = "#FFD90E66"
  case NewPinStroke = "#FFFFFF"

  case CurrentPinOverlay = "#99999933"
  case CurrentPinStroke = "#dddddd"

  static var ButtonTextColor: WalkColors {
    return NewPinOverlay
  }
  
  var uiColor: UIColor {
    return iiUIColor.fromHexString(rawValue)
  }
}
