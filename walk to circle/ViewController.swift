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

class ViewController: UIViewController, MKMapViewDelegate, iiOutputViewController,
  YiiButtonsDelegate, YiiMapDelegate {

  @IBOutlet weak var outputLabel: UILabel!
  private var locationManager: CLLocationManager!

  @IBOutlet var yiiButtons: YiiButtons!
  @IBOutlet var yiiMap: YiiMap!

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
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiButtonsDelegateImplementation = ViewController

extension YiiButtonsDelegateImplementation {
  func yiiButtonsDelegate_start() {
    self.yiiButtons.rewindButton.startCountdown()
    yiiMap.placeCircleOnMap()
  }
}

// ButtonsDelgate
// ------------------------------

typealias YiiMapDelegateImplementation = ViewController

extension YiiMapDelegateImplementation {
  func yiiMapDelegate_mapIsReady() {
    yiiButtons.showStartButton()
  }

  var yiiMapDelegate_startButton: UIView? {
    return yiiButtons.startButton
  }
}




