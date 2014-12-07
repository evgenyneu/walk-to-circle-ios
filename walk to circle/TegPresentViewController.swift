//
//  TegPresentViewController.swift
//  
//  Present view controller modally using its storyboard ID.
//
//  Created by Evgenii Neumerzhitckii on 28/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiPresentViewController {
  class func present(viewController: UIViewController, viewControllerId: String)
    -> UIViewController? {

    if let unwrapedViewController = instantiateViewControllerWithIdentifier(viewControllerId) {
      
      viewController.presentViewController(unwrapedViewController, animated: true, completion: nil)

      return unwrapedViewController
    }

    return nil
  }
  
  class func pushToNavigationController(viewController: UIViewController,
    viewControllerId: String) -> UIViewController? {
      
    let newViewController = instantiateViewControllerWithIdentifier(viewControllerId)
      
    if let unwrapedNewViewController = newViewController {
      viewController.navigationController?.pushViewController(unwrapedNewViewController,
        animated: true)
    }
      
    return newViewController
  }
  
  class func instantiateViewControllerWithIdentifier(viewControllerId: String) -> UIViewController? {
      
    let bundle = NSBundle.mainBundle()
    if let storyboardName = bundle.objectForInfoDictionaryKey("UIMainStoryboardFile" ) as? NSString {
      let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
      
      return storyboard.instantiateViewControllerWithIdentifier(viewControllerId) as? UIViewController
    }
      
    return nil
  }

  class func replaceRootViewController(fromViewController: UIViewController,
    viewControllerId: String, options: UIViewAnimationOptions) -> UIViewController? {

    let window = UIApplication.sharedApplication().windows[0] as UIWindow

    if let currentRootViewController = window.rootViewController {
      if currentRootViewController != fromViewController {
        // Only replace the view controller if it is root
        return nil
      }

      if let newViewController = instantiateViewControllerWithIdentifier(viewControllerId) {
        UIView.transitionFromView(
          currentRootViewController.view,
          toView: newViewController.view,
          duration: 1,
          options: options,
          completion: { finished in
            window.rootViewController = newViewController
        })

        return newViewController
      }
    }

    return nil
  }
}
