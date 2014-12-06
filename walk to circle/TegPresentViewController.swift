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

    if let unwrapedViewController =
      instantiateViewControllerWithIdentifier(viewController, viewControllerId: viewControllerId) {
      
      viewController.presentViewController(unwrapedViewController, animated: true, completion: nil)

      return unwrapedViewController
    }

    return nil
  }
  
  class func pushToNavigationController(viewController: UIViewController,
    viewControllerId: String) -> UIViewController? {
      
    let newViewController = instantiateViewControllerWithIdentifier(viewController,
      viewControllerId: viewControllerId)
      
    if let unwrapedNewViewController = newViewController {
      viewController.navigationController?.pushViewController(unwrapedNewViewController,
        animated: true)
    }
      
    return newViewController
  }
  
  class func instantiateViewControllerWithIdentifier(viewController: UIViewController,
    viewControllerId: String) -> UIViewController? {
      
    let bundle = NSBundle.mainBundle()
    if let storyboardName = bundle.objectForInfoDictionaryKey("UIMainStoryboardFile" ) as? NSString {
      let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
      
      return storyboard.instantiateViewControllerWithIdentifier(viewControllerId) as? UIViewController
    }
      
    return nil
  }
}
