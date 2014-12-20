//
//  iiAppVersion.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 20/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiOsVersion {
  class var version: Float {
    return (UIDevice.currentDevice().systemVersion as NSString).floatValue
  }
}
