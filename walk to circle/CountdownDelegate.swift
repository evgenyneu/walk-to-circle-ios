//
//  CountdownDelegate.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 29/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

protocol CountdownDelegate: class {
  func contdownDelegate_tick(value: Int)
  func contdownDelegate_didFinish()
}
