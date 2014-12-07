//
//  WalkLocation_regions_extension.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation
import CoreLocation

typealias WalkLocation_delegateRegions = WalkLocation

extension WalkLocation_delegateRegions {
  func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {

    
    WalkNotification.showNow("You reached your circle. Congrats!")
  }
}
