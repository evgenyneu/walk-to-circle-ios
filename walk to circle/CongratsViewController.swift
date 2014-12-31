//
//  CongratsViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class CongratsViewController: UIViewController {
  @IBOutlet weak var congratsLabel: UILabel!
  @IBOutlet weak var ciclesReachedLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    congratulate()
    showNumberOfCirclesReachedToday()
    fadeInLabels()
    playSound()
  }

  private func congratulate() {
    let numberOfCirclesReachedToday = WalkCirlesReachedToday.number
    let phrase = CongratsPhrase.oneRandomPhrase(numberOfCirclesReachedToday)
    congratsLabel.text = phrase
  }

  private func showNumberOfCirclesReachedToday() {
    let numberOfCirclesReachedToday = WalkCirlesReachedToday.number

    if numberOfCirclesReachedToday == 1 {
      ciclesReachedLabel.text = "You've reached your first circle today."
    } else {
      ciclesReachedLabel.text = "\(numberOfCirclesReachedToday) circles reached today."
    }
  }

  private func fadeInLabels() {
    iiAnimator.fadeInSpring(congratsLabel, duration: WalkConstants.textFadeInDuration, delay: 0.2)
    iiAnimator.fadeInSpring(ciclesReachedLabel, duration: WalkConstants.textFadeInDuration, delay: 0.2)
  }

  @IBAction func onPlayTapped(sender: AnyObject) {
    playSound()
  }

  private func playSound() {
    iiSounds.shared.play(iiSoundType.applause1, atVolume: 0.3)
  }

  @IBAction func onDoneTapped(sender: AnyObject) {
    iiSounds.shared.fadeOut(iiSoundType.applause1)
    WalkViewControllers.Map.show()
  }
}