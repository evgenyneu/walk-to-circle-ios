import Foundation

class WalkTutorial {
  class var showTutorial: Bool {
    // show tutorial screen if user has not reached any circles yet
    return !WalkUserDefaults.anyCircleReached.boolValue()
  }
}
