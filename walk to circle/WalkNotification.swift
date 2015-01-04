//
//  Notification.swift
//  Geo Regions Test
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit


class WalkNotification {
  class func showNow(text: String) {
    let notification = UILocalNotification()
    notification.fireDate = nil
    notification.alertBody = text
    notification.soundName = "notification.mp3"
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }

  class func registerNotifications() {
    if !UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))
    {
      return // there is no need to register local notifications in iOS 7
    }

    sendNotificationRegisterRequest()
  }

  private class func sendNotificationRegisterRequest() {
    let settings = UIUserNotificationSettings(forTypes: WalkConstants.notificationTypes,
      categories: nil)
    
    UIApplication.sharedApplication().registerUserNotificationSettings(settings)
  }
}
