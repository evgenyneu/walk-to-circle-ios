//
//  Countdown.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 29/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class Countdown: NSObject {
  private let countdownStartFrom = 10
  private var delayTimer:NSTimer?
  private var timer: NSTimer?

  var delegate: CountdownDelegate?

  private(set) var countdown = 0

  override init() {
    super.init()
  }

  func start() {
    stopTimer()
    countdown = countdownStartFrom
    reportTick()
    startDelayTimer()
  }

  private func reportTick() {
    delegate?.contdownDelegate_tick(countdown)
  }

  private func startTimer() {
    stopTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
      selector: "timerFired:", userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    if let currentTimer = timer {
      currentTimer.invalidate()
      timer = nil
    }
  }

  func timerFired(timer: NSTimer) {
    countdown--
    if countdown <= 0 {
      countdown = 0
      stopTimer()
    }
    reportTick()
  }

  private func startDelayTimer() {
    if let currentDelayTimer = delayTimer {
      currentDelayTimer.invalidate()
      delayTimer = nil
    }

    delayTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
      selector: "delayTimerFired:", userInfo: nil, repeats: false)
  }

  func delayTimerFired(timer: NSTimer) {
    startTimer()
  }

}
