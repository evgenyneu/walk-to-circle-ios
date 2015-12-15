import UIKit
import AVFoundation

class iiSoundPlayer {
  var player: AVAudioPlayer?
  var fader: iiFaderForAvAudioPlayer?

  init(fileName: String) {
    setAudioSessionToAmbient()

    let error: NSErrorPointer = nil
    let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), fileName as NSString, nil, nil)
    do {
      player = try AVAudioPlayer(contentsOfURL: soundURL)
    } catch let error1 as NSError {
      error.memory = error1
      player = nil
    }
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
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
    } catch _ {
    }
    do {
      try AVAudioSession.sharedInstance().setActive(true)
    } catch _ {
    }
  }

  func play(atVolume volume: Float = 1.0) {
    if let currentPlayer = player {
      currentPlayer.currentTime = 0
      currentPlayer.volume = volume
      currentPlayer.play()
    }
  }

  func playAsync(atVolume volume: Float = 1.0) {
    iiQ.async {
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

