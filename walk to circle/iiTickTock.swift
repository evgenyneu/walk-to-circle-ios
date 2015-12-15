import Foundation

class iiTickTock {
  var startTime:NSDate

  init() {
    startTime = NSDate()
  }

  func measure() -> Double {
    return Double(Int(-startTime.timeIntervalSinceNow * 10000)) / 10
  }

  func formatted() -> String {
    let elapsedMs = measure()
    return String(format: "%.1f", elapsedMs)
  }

  func formattedWithMs() -> String {
    return "[TOCK] \(formatted()) ms"
  }

  func output() {
    print(formattedWithMs())
  }

  func outputView() {
    iiOutputView.show(formattedWithMs())
  }
}
