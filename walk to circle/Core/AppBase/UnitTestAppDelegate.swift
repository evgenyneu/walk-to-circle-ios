import UIKit

public class UnitTestAppDelegate: UIResponder, UIApplicationDelegate {
  public var window: UIWindow?

  
  public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.purpleColor()
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    return true
  }
}

