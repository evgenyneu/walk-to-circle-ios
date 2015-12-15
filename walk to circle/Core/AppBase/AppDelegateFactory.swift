import Foundation

class AppDelegateFactory {
  class var appDelegateClassName: String {
    if isUnitTesting {
      return NSStringFromClass(UnitTestAppDelegate)
    } else {
      return NSStringFromClass(AppDelegate)
    }
  }
  
  class var isUnitTesting: Bool {
    return NSClassFromString("XCTest") != nil
  }
}