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
  private var soundPlayed: WalkSoundType?

  init() { }

  public func play() {
    let ciclesReached = WalkUserDefaults.circlesReachedToday.intValue(0)

    if let sound = CongratsSounds.soundType(ciclesReached) {
      soundPlayed = sound
      iiSounds.shared.play(sound, atVolume: 0.5)
    }
  }

  public func stop() {
    if let currentSoundPlayed = soundPlayed {
      iiSounds.shared.fadeOut(currentSoundPlayed)
    }
  }
  
  public class func fileName(circlesReachedToday: Int) -> String {
    var currentNumber = walkCongratsSounds.first ?? 1

    for number in walkCongratsSounds {
      if number > circlesReachedToday { break }
      currentNumber = number
    }

    return "applause_\(currentNumber).mp3"
  }

  public class func soundType(circlesReachedToday: Int) -> WalkSoundType? {
    let name = fileName(circlesReachedToday)
    return WalkSoundType(rawValue: name)
  }
}
