import UIKit

class iiSettingsOpener {
  class func openSettings() {
    if !canOpenAppSettings { return }

    if let appSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString) {
      UIApplication.sharedApplication().openURL(appSettingsUrl)
    }
  }

  class var canOpenAppSettings: Bool {
    return iiOsVersion.version >= 8
  }
}
