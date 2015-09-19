//
//  ViewController.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 6/07/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class MapViewController: UIViewController, MKMapViewDelegate, iiOutputViewController,
  YiiButtonsDelegate, YiiMapDelegate, CountdownDelegate {

  @IBOutlet weak var outputLabel: UILabel!

  @IBOutlet var yiiButtons: YiiButtons!
  @IBOutlet var yiiMap: YiiMap!

  let countdown = Countdown()

  override func viewDidLoad() {
    super.viewDidLoad()

    yiiMap.viewDidLoad()
    yiiMap.delegate = self

    yiiButtons.viewDidLoad()
    yiiButtons.delegate = self

    countdown.delegate = self

    showPreviousPin()

    // Preload pin drop sounds to make it play without delay and in sync with animation
    iiSounds.shared.prepareToPlay(iiSoundType.fall)
    iiSounds.shared.prepareToPlay(iiSoundType.pin_drop)
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.Default
  }

  private func showPreviousPin() {
    if let previousCoordinate = WalkCoordinate.previous {
      yiiMap.showPreviousPin(previousCoordinate)
    }
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiButtonsDelegateImplementation = MapViewController

extension YiiButtonsDelegateImplementation {
  func yiiButtonsDelegate_start() {
    countdown.start()
    let newCoordinate = yiiMap.dropNewPin()

    iiQ.main {
      // Defer saving new coordinate because it can slow down UI 
      WalkCoordinate.current = newCoordinate
      WalkCircleMonitor.start()
    }
  }
}

// MapDelgate
// ------------------------------

typealias YiiMapDelegateImplementation = MapViewController

extension YiiMapDelegateImplementation {
  func yiiMapDelegate_mapIsReady() {
    yiiButtons.showStartButton()
  }

  var yiiMapDelegate_startButton: UIView? {
    return yiiButtons.startButton
  }
}

// CountdownDelegate
// ------------------------------

typealias CountdownDelegateImplementation = MapViewController

extension CountdownDelegateImplementation {
  func contdownDelegate_tick(value: Int, firstTick: Bool) {
    yiiButtons.rewindButton.updateText(String(value))

    if !firstTick {
      iiSounds.shared.play(iiSoundType.click_sound, atVolume: 0.2)
    }
  }

  func contdownDelegate_didFinish() {
    iiSounds.shared.play(iiSoundType.large_door, atVolume: 0.15)
    iiQ.runAfterDelay(0.01) { // Show zero before view transition
      WalkViewControllers.Walk.show()
    }
  }
}




