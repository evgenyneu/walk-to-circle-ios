//
//  iiTickTock.swift
//  
//  Measures elapsed time 
//
//  Usage:
//
//    let timer = iiTickTock()
//    ... code to measure execution time for
//    timer.output()
//
//    Output: [TOCK] 10.2 ms
//
//  Created by Evgenii Neumerzhitckii on 11/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

class iiTickTock {
  var startTime:NSDate

  init() {
    startTime = NSDate()
  }

  func measure() -> Double {
    return Double(Int(-startTime.timeIntervalSinceNow * 10000)) / 10
  }

  func formatted() -> String {
    let elapsedMs = measure()
    return String(format: "%.1f", elapsedMs)
  }

  func formattedWithMs() -> String {
    return "[TOCK] \(formatted()) ms"
  }

  func output() {
    print(formattedWithMs())
  }

  func outputView() {
    iiOutputView.show(formattedWithMs())
  }
}
