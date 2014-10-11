//
//  SoundPlayer.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 7/09/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import AVFoundation

enum SoundType: String {
  case ballBounce = "ball_bounce.wav"
  case fall = "fall.wav"
  case blop = "blop.wav"
}

class SoundPlayer {

  var player: AVAudioPlayer?

  init() { }

  func play(soundType: SoundType, atVolume volume: Float = 1.0) {
    play(soundType.rawValue, atVolume: volume)
  }

  func play(fileName: String, atVolume volume: Float = 1.0) {
    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)

    player = AVAudioPlayer(contentsOfURL: soundURL, error: error)
    play(atVolume: volume)
  }

  private func play(atVolume volume: Float = 1.0) {
    if let currentPlayer = player {
      currentPlayer.volume = volume
      currentPlayer.play()
    }
  }
}
