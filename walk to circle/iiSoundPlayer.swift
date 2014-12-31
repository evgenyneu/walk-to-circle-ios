//
//  iiSoundPlayer.swift
//  
//  Plays sounds
//
//  Created by Evgenii Neumerzhitckii on 11/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import AVFoundation

enum iiSoundType: String {
  case pin_drop = "pin_drop.mp3"
  case fall = "snow_ball_throw_short.wav"
  case blop = "blop.wav"
  case large_door = "large_door.mp3"
  case click_sound = "click_sound.wav"
  case applause1 = "applause-01.mp3"
}

class iiSoundPlayer {
  var player: AVAudioPlayer?
  var fader: iiFaderForAvAudioPlayer?

  init(fileName: String) {
    setAudioSessionToAmbient()

    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)
    player = AVAudioPlayer(contentsOfURL: soundURL, error: error)
  }

  convenience init(soundType: iiSoundType) {
    self.init(fileName: soundType.rawValue)
  }

  func prepareToPlay() {
    if let currentPlayer = player {
      currentPlayer.prepareToPlay()
    }
  }

  // Allows the sounds to be played with sounds from other apps
  func setAudioSessionToAmbient() {
    AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient, error: nil)
    AVAudioSession.sharedInstance().setActive(true, error: nil)
  }

  func play(atVolume volume: Float = 1.0) {
    if let currentPlayer = player {
      currentPlayer.currentTime = 0
      currentPlayer.volume = volume
      currentPlayer.play()
    }
  }

  func playAsync(atVolume volume: Float = 1.0) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      self.play(atVolume: volume)
    }
  }

  func fadeOut() {
    if let currentPlayer = player {
      if let currentFader = fader {
        currentFader.stop()
      }

      let newFader = iiFaderForAvAudioPlayer(player: currentPlayer)
      fader = newFader
      newFader.fadeOut()
    }
  }
}

