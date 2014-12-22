//  
//  Present view controller modally using its storyboard ID.
//
//  Created by Evgenii Neumerzhitckii on 28/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiPresentViewController {
  class func instantiateViewControllerWithIdentifier(viewControllerId: String) -> UIViewController? {
      
    let bundle = NSBundle.mainBundle()
    if let storyboardName = bundle.objectForInfoDictionaryKey("UIMainStoryboardFile" ) as? NSString {
      let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
      
      return storyboard.instantiateViewControllerWithIdentifier(viewControllerId) as? UIViewController
    }
      
    return nil
  }

  class func replaceRootViewController(
    viewControllerId: String, options: UIViewAnimationOptions, duration: NSTimeInterval) -> UIViewController? {

    let window = UIApplication.sharedApplication().windows[0] as UIWindow

    if let currentRootViewController = window.rootViewController {

      if let newViewController = instantiateViewControllerWithIdentifier(viewControllerId) {
        UIView.transitionFromView (
          currentRootViewController.view,
          toView: newViewController.view,
          duration: duration,
          options: options,
          completion: { finished in
            window.rootViewController = newViewController
        })

        return newViewController
      }
    }

    return nil
  }

  class func setRootViewController(viewControllerId: String) {
    if let newViewController = instantiateViewControllerWithIdentifier(viewControllerId) {
      let window = UIApplication.sharedApplication().windows[0] as UIWindow
      window.rootViewController = newViewController
      window.makeKeyAndVisible()
    }
  }

}
