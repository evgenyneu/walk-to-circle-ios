//
//  Show Start and Rewind buttons on the map
//
//  Created by Evgenii Neumerzhitckii on 22/11/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class YiiButtons: NSObject {
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var rewindButton: RewindButton!

  weak var delegate: YiiButtonsDelegate?

  @IBAction func onStartTapped(sender: AnyObject) {
    start()
  }

  @IBAction func onRewindTapped(sender: AnyObject) {
    rewind()
  }

  func viewDidLoad() {
    YiiButtons.initButton(startButton)
    YiiButtons.initButton(rewindButton)
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
    delegate?.yiiButtonsDelegate_start()
    iiAnimator.rotate3d360(rewindButton)
  }

  private func start() {
    delegate?.yiiButtonsDelegate_start()

    showRewindButton()

    // Rotate start button
    startButton.layer.zPosition = 1000
    iiAnimator.rotate3dOut(startButton)
    iiAnimator.fadeOut(startButton, duration: 0.1)

    // Rotate rewind button
    rewindButton.layer.zPosition = 999

    iiAnimator.rotate3dIn(rewindButton)
    iiAnimator.fadeIn(rewindButton, duration: 0.1)
  }
}
