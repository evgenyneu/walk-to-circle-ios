import UIKit

enum WalkViewControllers: String {
  case InitialDummy = "initial view controller"
  case Map = "map view controller"
  case Walk = "walk view controller"
  case Congrats = "congrats view controller"

  // Error view controllers
  case LocationDenied = "location denied controller"
  case RegionMonitoringUnavailable = "region monitoring unavailable controller"

  private static private(set) var currentlyPresented: WalkViewControllers?

  private static var anyControllerPresentedYet: Bool {
    return currentlyPresented != nil
  }

  func show(animate: Bool = true) {
    if WalkViewControllers.anyControllerPresentedYet && WalkViewControllers.currentlyPresented == self {
      // This view controller is already being shown
      return
    }

    // Present view controller unless we are in background, in which case it will be presented later
    // when application becomes active again.
    if UIApplication.sharedApplication().applicationState != UIApplicationState.Background {
      presentViewController(animate)
    }

    WalkViewControllers.toBePresented = self
  }

  private func presentViewController(animate: Bool = true) {
    
    if AppDelegateFactory.isUnitTesting { return }

    if WalkViewControllers.anyControllerPresentedYet && animate {

      let options = self == WalkViewControllers.Map ?
        UIViewAnimationOptions.TransitionFlipFromBottom : UIViewAnimationOptions.TransitionFlipFromTop

      iiPresentViewController.replaceRootViewController(rawValue,
        options: options,
        duration: WalkConstants.viewControllerTransitionDuration)

    } else {
      // No controller was presented yet. Currentl root view controller is a blank dummy
      // Replace it with new controller without animation.
      iiPresentViewController.setRootViewController(rawValue)
    }

    WalkViewControllers.currentlyPresented = self
  }

  // View controller that will be presented when app becomes active
  static var toBePresented: WalkViewControllers {
    get {
      let defaultViewController = WalkViewControllers.Map

      if let currentViewControllerName = WalkUserDefaults.currentViewControllerId.value as? String {
        return WalkViewControllers(rawValue: currentViewControllerName) ?? defaultViewController
      }

      return defaultViewController
    }

    set {
      WalkUserDefaults.currentViewControllerId.save(newValue.rawValue)

      if !newValue.isErrorViewController {
        WalkUserDefaults.currentNonErrorViewControllerId.save(newValue.rawValue)
      }
    }
  }

  // Non error view controller that will be presented when app becomes active
  static var nonErrorToBePresented: WalkViewControllers {
    get {
      let defaultViewController = WalkViewControllers.Map

      if let currentViewControllerName = WalkUserDefaults.currentNonErrorViewControllerId.value as? String {
        return WalkViewControllers(rawValue: currentViewControllerName) ?? defaultViewController
      }

      return defaultViewController
    }
  }

  private var isErrorViewController: Bool {
    let errorViewControllers = [
      WalkViewControllers.LocationDenied,
      WalkViewControllers.RegionMonitoringUnavailable]

    return errorViewControllers.contains(self)
  }
}