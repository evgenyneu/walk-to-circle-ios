import UIKit

class LocationDeniedViewController: UIViewController {
  @IBOutlet weak var openAppSettingsButton: UIButton!
  @IBOutlet weak var settingsInstructionLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    if iiSettingsOpener.canOpenAppSettings {
      iiViewPosition.hide(settingsInstructionLabel)
    } else {
      openAppSettingsButton.removeFromSuperview()
    }
  }

  @IBAction func onOpenAppSettingsTapped(sender: AnyObject) {
    iiSettingsOpener.openSettings()
  }
}