//
//  MapButtons.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 22/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class MapButtons: NSObject {
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var rewindButton: RewindButton!

  var delegate: ButtonsDelegate?

  @IBAction func onStartTapped(sender: AnyObject) {
    start()
  }

  @IBAction func onRewindTapped(sender: AnyObject) {
    println("On rewind button tapped")
  }

  func viewDidLoad() {
    MapButtons.initButton(startButton)
    MapButtons.initButton(rewindButton)
  }

  private class func initButton(button: UIButton) {
    button.backgroundColor = nil
    button.setTitle("", forState: UIControlState.Normal)
    button.hidden = true
  }

  func showStartButton() {
    if !startButton.hidden { return }
    startButton.hidden = false
    iiSounds.shared.play(iiSoundType.blop, atVolume: 0.1)
    iiAnimator.bounce(startButton)
  }

  private func showRewindButton() {
    if !rewindButton.hidden { return }
    rewindButton.hidden = false
  }

  func start() {
    delegate?.buttonsDelegateInStart()

    showRewindButton()

    startButton.userInteractionEnabled = false
    rewindButton.userInteractionEnabled = false

    iiAnimator.rotate3dOut(startButton)
    iiAnimator.fadeOut(startButton, duration: 0.1)

    iiAnimator.rotate3dIn(rewindButton) {
      self.rewindButton.userInteractionEnabled = true
    }

    iiAnimator.fadeIn(rewindButton, duration: 0.1)
  }
}
