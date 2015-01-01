//
//  CongratsSounds.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 1/01/2015.
//  Copyright (c) 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public var walkCongratsSounds = [1, 2, 3, 4, 6, 7, 9, 12, 15, 20]

public class CongratsSounds {
  public class func getFileName(circlesReachedToday: Int) -> String {
    var currentNumber = walkCongratsSounds.first ?? 1

    for number in walkCongratsSounds {
      if number > circlesReachedToday { break }
      currentNumber = number
    }

    return "applause_\(currentNumber).mp3"
  }
}
