//
//  YiiMapDelegate.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 23/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

protocol YiiMapDelegate {
  func yiiMapDelegate_mapIsReady()
  var yiiMapDelegate_startButton: UIView? {get}
}
