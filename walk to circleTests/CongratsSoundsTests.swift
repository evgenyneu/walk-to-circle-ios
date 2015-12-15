import Foundation

import UIKit
import WalkToCircle
import XCTest

class CongratsSoundsTests: XCTestCase {
  func testGetFileName() {
    XCTAssertEqual("applause_1.mp3", CongratsSounds.fileName(1))
    XCTAssertEqual("applause_2.mp3", CongratsSounds.fileName(2))
    XCTAssertEqual("applause_3.mp3", CongratsSounds.fileName(3))
    XCTAssertEqual("applause_4.mp3", CongratsSounds.fileName(5))
    XCTAssertEqual("applause_7.mp3", CongratsSounds.fileName(7))
    XCTAssertEqual("applause_9.mp3", CongratsSounds.fileName(9))
    XCTAssertEqual("applause_12.mp3", CongratsSounds.fileName(14))
    XCTAssertEqual("applause_20.mp3", CongratsSounds.fileName(20))

    // Edge cases

    XCTAssertEqual("applause_1.mp3", CongratsSounds.fileName(-1))
    XCTAssertEqual("applause_1.mp3", CongratsSounds.fileName(0))
    XCTAssertEqual("applause_20.mp3", CongratsSounds.fileName(1232))
  }

  func testGetSoundType() {
    XCTAssertEqual(WalkSoundType.applause_6, CongratsSounds.soundType(6)!)
  }
}
