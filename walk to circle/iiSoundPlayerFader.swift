//
//  iiSoundPlayerFadeOut.swift
//  WalkToCircle
//
//  Created by Evgenii Neumerzhitckii on 31/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import AVFoundation

let iiSoundPlayerFader_defaultFadeIntervalSeconds = 2.0
let iiSoundPlayerFader_defaultVelocity = 5.0


@objc
public class iiSoundPlayerFader {
  let player: AVAudioPlayer
  private var timer: NSTimer?

  private let stepsPerSecond = 10.0
  private var fadeIntervalSeconds = iiSoundPlayerFader_defaultFadeIntervalSeconds

  private var startVolume = 0.0
  private var currentStep = 0

  init(player: AVAudioPlayer) {
    self.player = player
  }

  deinit {
    stopTimer()
  }

  func fadeOut(fadeIntervalSeconds: Double = iiSoundPlayerFader_defaultFadeIntervalSeconds) {
    self.fadeIntervalSeconds = fadeIntervalSeconds
    startVolume = Double(player.volume)

    startTimer()
  }

  private func startTimer() {
    stopTimer()
    if startVolume <= 0 { return }
    currentStep = 0

    timer = NSTimer.scheduledTimerWithTimeInterval(1 / stepsPerSecond, target: self,
      selector: "timerFired:", userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    if let currentTimer = timer {
      currentTimer.invalidate()
      timer = nil
    }
  }

  func timerFired(timer: NSTimer) {

    var newVolume = player.volume

    println("Fading out \(newVolume)")

    if newVolume <= 0.0001 {
      newVolume = 0
      stopTimer()
    }

    player.volume = newVolume
  }

  public class func timeValue(currentStep: Int, fadeIntervalSeconds: Double,
    stepsPerSecond: Double, velocity: Double) -> Double {

    let totalSteps = fadeIntervalSeconds * stepsPerSecond
    let timeValue = Double(currentStep) / totalSteps
      return iiSoundPlayerFader.timeValue(timeValue, velocity: velocity)
  }

  public class func timeValue(timeFromZeroToOne: Double, velocity: Double) -> Double {
    var time = timeFromZeroToOne
    if time < 0 { time = 0 }
    if time > 1 { time = 1 }
    return pow(M_E, -time * velocity)
  }
}
