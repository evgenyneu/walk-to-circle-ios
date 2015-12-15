import UIKit
import WalkToCircle
import XCTest

class CongratsPhraseTests: XCTestCase {

  // oneRandomPhrase
  // -----------------

  func testGetRandom() {
    walkCongratsPhrases[1] = ["Test one"]
    walkCongratsPhrases[2] = ["Test two"]
    walkCongratsPhrases[5] = ["Test five"]
    walkCongratsPhrases[20] = ["Test Oh My Glob!"]

    XCTAssertEqual("Test one", CongratsPhrase.oneRandomPhrase(1))
    XCTAssertEqual("Test two", CongratsPhrase.oneRandomPhrase(2))
    XCTAssertEqual("Test two", CongratsPhrase.oneRandomPhrase(3))
    XCTAssertEqual("Test five", CongratsPhrase.oneRandomPhrase(5))

    // Edge cases
    XCTAssertEqual("Test Oh My Glob!", CongratsPhrase.oneRandomPhrase(1000))
    XCTAssertEqual("Test one", CongratsPhrase.oneRandomPhrase(0))
  }

  func testGetRandom_returnsUnseenOne() {
    walkCongratsPhrases[1] = ["a", "b", "c", "d"]
    walkCongratsPhrasesSeenToday = ["a", "b", "d"]
    XCTAssertEqual("c", CongratsPhrase.oneRandomPhrase(1))
  }

  func testGetRandom_remembersPhraseInTodaysList() {
    walkCongratsPhrases[1] = ["Something to remember"]
    walkCongratsPhrasesSeenToday = []

    CongratsPhrase.oneRandomPhrase(1)

    XCTAssertEqual(["Something to remember"], walkCongratsPhrasesSeenToday)
  }

  func testGetRandom_remembersPhraseOnlyOnce() {
    walkCongratsPhrases[1] = ["Something to remember"]
    walkCongratsPhrasesSeenToday = []

    CongratsPhrase.oneRandomPhrase(1)
    CongratsPhrase.oneRandomPhrase(1)
    CongratsPhrase.oneRandomPhrase(1)

    XCTAssertEqual(["Something to remember"], walkCongratsPhrasesSeenToday)
  }

  // oneRandomPhrase from array
  // -----------------

  func testPickRandomPhraseFomrArray() {
    var result = CongratsPhrase.oneRandomPhrase(["a"])
    XCTAssertEqual("a", result)

    result = CongratsPhrase.oneRandomPhrase([])
    XCTAssertEqual(walkCongratsNoPhraseFound, result)
  }

  // Get random phrases
  // -----------------

  func testGetPhrases() {
    walkCongratsPhrases[1] = ["Test one"]
    walkCongratsPhrases[2] = ["Test two"]
    walkCongratsPhrases[5] = ["Test five"]
    walkCongratsPhrases[8] = ["Test eight"]
    walkCongratsPhrases[13] = ["Test 13"]
    walkCongratsPhrases[20] = ["Test Oh My Glob!"]

    var result = CongratsPhrase.getPhrases(1)
    XCTAssertEqual(["Test one"], result)

    result = CongratsPhrase.getPhrases(2)
    XCTAssertEqual(["Test two"], result)

    result = CongratsPhrase.getPhrases(3)
    XCTAssertEqual(["Test two"], result)

    result = CongratsPhrase.getPhrases(5)
    XCTAssertEqual(["Test five"], result)

    result = CongratsPhrase.getPhrases(12)
    XCTAssertEqual(["Test eight"], result)

    result = CongratsPhrase.getPhrases(21)
    XCTAssertEqual(["Test Oh My Glob!"], result)

    // Edge cases
    result = CongratsPhrase.getPhrases(0)
    XCTAssertEqual(["Test one"], result)

    result = CongratsPhrase.getPhrases(123123)
    XCTAssertEqual(["Test Oh My Glob!"], result)

    result = CongratsPhrase.getPhrases(-123123)
    XCTAssertEqual(["Test one"], result)
  }

  // Unseen phrases
  // -----------------

  func testUnseenPhrasesToday() {
    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"], alreadySeenToday: ["a"])
    XCTAssertEqual(["b", "c"], result)
  }

  func testUnseenPhrasesToday_withGlobalPhrases() {
    walkCongratsPhrasesSeenToday = ["b"]
    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"])
    XCTAssertEqual(["a", "c"], result)
  }

  func testUnseenPhrasesToday_withGlobalPhrases_whenAllSeen() {
    walkCongratsPhrasesSeenToday = ["b", "c", "a"]

    let result = CongratsPhrase.unseenPhrasesToday(["a", "b", "c"])

    XCTAssertEqual(["a", "b", "c"], result)
    XCTAssertEqual([], walkCongratsPhrasesSeenToday)
  }
}