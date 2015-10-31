import CoreLocation
@testable import WalkToCircle
import XCTest

class WatchParentReplyInfoTests: XCTestCase {
  
  func testReplyWithDirection() {
    // 136 degress
    TestLocationHelper.setTestUserLocation(CLLocationCoordinate2DMake(
      -37.847480, 144.969737))
    
    WalkCoordinate.current = CLLocationCoordinate2DMake(-37.861644, 144.986903)
    
    let result: [String: AnyObject] = WatchParentReplyInfo.data
    
    XCTAssertEqual(result["walk direction"] as? Int, 6)
  }
  
  func testReplyWithDirection_noWalkCoordinate() {
    // 136 degress
    TestLocationHelper.setTestUserLocation(CLLocationCoordinate2DMake(
      -37.847480, 144.969737))
    
    WalkCoordinate.current = nil
    
    let result: [String: AnyObject] = WatchParentReplyInfo.data
    
    XCTAssertEqual(result["walk direction"] as? Int, -9973)
  }
}
