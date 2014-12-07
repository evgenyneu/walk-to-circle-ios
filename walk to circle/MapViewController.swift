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
  private var locationManager: CLLocationManager!

  @IBOutlet var yiiButtons: YiiButtons!
  @IBOutlet var yiiMap: YiiMap!

  let countdown = Countdown()

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    yiiMap.viewDidLoad()
    yiiMap.delegate = self

    yiiButtons.viewDidLoad()
    yiiButtons.delegate = self

    countdown.delegate = self
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiButtonsDelegateImplementation = MapViewController

extension YiiButtonsDelegateImplementation {
  func yiiButtonsDelegate_start() {
    countdown.start()
    yiiMap.placeCircleOnMap()
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
    iiPresentViewController.replaceRootViewController(self,
      viewControllerId: "walk view controller", options: .TransitionFlipFromTop)
  }
}




