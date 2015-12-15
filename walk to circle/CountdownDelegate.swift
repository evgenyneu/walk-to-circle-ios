import Foundation

protocol CountdownDelegate: class {
  func contdownDelegate_tick(value: Int, firstTick: Bool)
  func contdownDelegate_didFinish()
}
