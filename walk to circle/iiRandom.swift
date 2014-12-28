//
//  iiRandom.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 28/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public struct iiRandom {
  public static var randomBetween0And1: Double {
    return Double(arc4random()) / Double(UINT32_MAX)
  }
}