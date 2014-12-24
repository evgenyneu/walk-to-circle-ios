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

  deinit {
    println("deinit MapViewController")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    yiiMap.viewDidLoad()
    yiiMap.delegate = self

    yiiButtons.viewDidLoad()
    yiiButtons.delegate = self

    countdown.delegate = self

    showCurrentPin()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    WalkRegions.stopMonitoringForAllRegions()
  }

  private func showCurrentPin() {
    if let currentCoordinate = WalkCoordinate.current {
      yiiMap.showCurrentPin(currentCoordinate)
    }
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiButtonsDelegateImplementation = MapViewController

extension YiiButtonsDelegateImplementation {
  func yiiButtonsDelegate_start() {
    countdown.start()
    
    yiiMap.dropNewPin()

    if let currentCoordinate = WalkCoordinate.current {
      WalkRegions.startMonitoringForCoordinate(currentCoordinate)
    }
  }
}

// ButtonsDelgate
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
  func contdownDelegate_tick(value: Int) {
    yiiButtons.rewindButton.updateText(String(value))
  }

  func contdownDelegate_didFinish() {
    iiQ.runAfterDelay(0.01) { // Show zero before view transition
      WalkViewControllers.Walk.show()
    }
  }
}




