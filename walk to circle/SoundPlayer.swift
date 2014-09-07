//
//  SoundPlayer.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 7/09/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import AVFoundation

class SoundPlayer {
  lazy var bubbleSound: SystemSoundID = {
    var soundID: SystemSoundID = 0
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "ball_bounce", "wav", nil)
    AudioServicesCreateSystemSoundID(soundURL, &soundID)
    return soundID
  }()

  func playBubble() {
    AudioServicesPlaySystemSound(bubbleSound)
  }
}
