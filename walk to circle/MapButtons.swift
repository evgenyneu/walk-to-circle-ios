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
    rewind()
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

  private func disableButtonsInteraction() {
    startButton.userInteractionEnabled = false
    rewindButton.userInteractionEnabled = false
  }

  private func rewind() {
    disableButtonsInteraction()
    delegate?.buttonsDelegateStart()

    iiAnimator.rotate3d360(rewindButton) {
      self.rewindButton.userInteractionEnabled = true
    }
  }

  private func start() {
    disableButtonsInteraction()
    delegate?.buttonsDelegateStart()

    showRewindButton()

    // Rotate start button
    startButton.layer.zPosition = 1000
    iiAnimator.rotate3dOut(startButton)
    iiAnimator.fadeOut(startButton, duration: 0.1)

    // Rotate rewind button
    rewindButton.layer.zPosition = 999

    iiAnimator.rotate3dIn(rewindButton) {
      self.rewindButton.userInteractionEnabled = true
    }

    iiAnimator.fadeIn(rewindButton, duration: 0.1)
  }
}
