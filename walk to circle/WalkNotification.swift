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
    notification.soundName = UILocalNotificationDefaultSoundName
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }
}
