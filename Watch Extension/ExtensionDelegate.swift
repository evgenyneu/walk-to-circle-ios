//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Evgenii on 19/09/2015.
//  Copyright © 2015 Evgenii Neumerzhitckii. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
  
  let watchCommunicator = WatchCommunicator()
  let watchToParentPinger = WatchToParentPinger()
  
  func applicationDidFinishLaunching() {
    watchCommunicator.activateWatchConnectivity()
    watchToParentPinger.start()    
  }
  
  func applicationDidBecomeActive() {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillResignActive() {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
  }
}
