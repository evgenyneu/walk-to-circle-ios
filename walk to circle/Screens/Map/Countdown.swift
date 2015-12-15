import UIKit

class Countdown: NSObject {
  private var delayTimer:NSTimer?
  private var timer: NSTimer?

  weak var delegate: CountdownDelegate?

  private(set) var countdown = 0

  override init() {
    super.init()
  }

  deinit {
    stopCurrentDelayTimer()
    stopTimer()
  }

  func start() {
    stopTimer()
    countdown = WalkConstants.mapCountdownIntervalSeconds
    reportTick()
    startDelayTimer()
  }

  private func reportTick() {
    delegate?.contdownDelegate_tick(countdown, firstTick: countdown == WalkConstants.mapCountdownIntervalSeconds)
  }

  private func reportDidFinish() {
    delegate?.contdownDelegate_didFinish()
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

    if countdown <= 0 {
      countdown = 0
      stopTimer()
      reportTick()
      reportDidFinish()
      return
    }

    reportTick()
  }

  private func startDelayTimer() {
    stopCurrentDelayTimer()
    delayTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
      selector: "delayTimerFired:", userInfo: nil, repeats: false)
  }

  private func stopCurrentDelayTimer() {
    if let currentDelayTimer = delayTimer {
      currentDelayTimer.invalidate()
      delayTimer = nil
    }
  }

  func delayTimerFired(timer: NSTimer) {
    startTimer()
  }

}
