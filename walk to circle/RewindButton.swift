//
//  RewindButton.swift
//  walk to circle
//
//  Created by Evgenii Neumerzhitckii on 19/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import QuartzCore

class RewindButton: UIButton {

  private let countdownLabel = UILabel()

  private let iiFont = UIFont.systemFontOfSize(40)
  private let iiColor = UIColor(red: 255 / 255, green: 217 / 255, blue: 14 / 255, alpha: 0.4)
  private let countdownStartFrom = 60
  private var delayTimer:NSTimer?
  private var timer: NSTimer?

  private(set) var countdown = 0

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    initLabel()
    showArrows()
  }

  func startCountdown() {
    stopTimer()
    countdown = countdownStartFrom
    updateText()
    startDelayTimer()
  }

  private func updateText() {
    let attributedText = NSAttributedString(string: String(countdown), attributes: [
      NSForegroundColorAttributeName: iiColor,
      NSFontAttributeName: iiFont,
      NSTextEffectAttributeName: NSTextEffectLetterpressStyle
      ])

    countdownLabel.attributedText = attributedText
  }

  private func initLabel() {
    countdownLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

    RewindButton.positionContdownLabel(self, label: countdownLabel)
  }

  private func showArrows() {
    let arrowsLayer = CALayer()
    iiLayer.loadImage(inLayer: arrowsLayer, imageName: "rewind_arrows")
    iiLayer.centerInParent_withSizeOfParent(arrowsLayer, parentBounds: bounds)
    self.layer.addSublayer(arrowsLayer)

    RewindButton.rotateArrows(arrowsLayer)
  }

  private class func rotateArrows(layer: CALayer) {
    iiAnimator.addInfiniteAnimation(layer, keyPath: "transform.rotation.z",
      fromVaue: 0, toValue: -M_PI, duration: 1, autoreverses: false)
  }

  private class func positionContdownLabel(superview: UIView, label: UILabel) {
    superview.addSubview(label)

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterX,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterX,
      multiplier: 1,
      constant: 0))

    superview.addConstraint(NSLayoutConstraint(
      item: superview,
      attribute: NSLayoutAttribute.CenterY,
      relatedBy: NSLayoutRelation.Equal,
      toItem: label,
      attribute: NSLayoutAttribute.CenterY,
      multiplier: 1,
      constant: 0))
  }

  private func startTimer() {
    stopTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
      selector: "timerFired:", userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    if let currentTimer = timer {
      currentTimer.invalidate()
      timer = nil
    }
  }

  func timerFired(timer: NSTimer) {
    countdown--
    if countdown <= 0 { countdown = countdownStartFrom }
    updateText()
  }

  private func startDelayTimer() {
    if let currentDelayTimer = delayTimer {
      currentDelayTimer.invalidate()
      delayTimer = nil
    }

    delayTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
      selector: "delayTimerFired:", userInfo: nil, repeats: false)
  }

  func delayTimerFired(timer: NSTimer) {
    startTimer()
  }
}
