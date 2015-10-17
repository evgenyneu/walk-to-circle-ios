import WatchKit

enum WalkInterfaceControllers: String {
  case Walk
  
  func push(interfaceController: WKInterfaceController) {
    interfaceController.pushControllerWithName(self.rawValue, context: nil)
  }
}