//
//  iiSounds.swift
//
//  Play sounds. It creates and caches sound players. Sounds are played asynchronously.
//
//  Created by Evgenii Neumerzhitckii on 11/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

private let _shared_iiSounds = iiSounds()

class iiSounds {
  class var shared: iiSounds {
    return _shared_iiSounds
  }
  
  private(set) var soundPlayers = [iiSoundType: iiSoundPlayer]()
  
  private init() { }
  
  func play(type: iiSoundType, atVolume volume: Float = 1.0) {
    if soundPlayers[type] == nil {
      soundPlayers[type] = iiSoundPlayer(soundType: type)
    }
    
    if let currentPlayer = soundPlayers[type] {
      currentPlayer.playAsync(atVolume: volume)
    }
  }

  func fadeOut(type: iiSoundType, atVolume volume: Float = 1.0) {
    if let currentPlayer = soundPlayers[type] {
      currentPlayer.fadeOut()
    }
  }
}

