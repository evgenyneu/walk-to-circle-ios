import CoreLocation
import WalkToCircle
import XCTest

class WalkCirlesReachedTodayTests: XCTestCase {
  func testIncrement() {
    WalkUserDefaults.circlesReached.clear()
    WalkUserDefaults.lastCircleReachedDate_yearMonthDay.clear()

    WalkCirlesReachedToday.increment()

    XCTAssertEqual(1, WalkCirlesReachedToday.number)

    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()
    WalkCirlesReachedToday.increment()

    XCTAssertEqual(4, WalkCirlesReachedToday.number)
  }

  func testGetNumberOfCirclesReachedForDate() {
    WalkUserDefaults.circlesReached.clear()
    WalkUserDefaults.lastCircleReachedDate_yearMonthDay.clear()

    let date = iiDate.fromYearMonthDay(2031, month: 5, day: 4)!

    var result = WalkCirlesReachedToday.number(date)
    XCTAssertEqual(0, result)

    WalkCirlesReachedToday.increment(date)
    WalkCirlesReachedToday.increment(date)

    result = WalkCirlesReachedToday.number(date)

    XCTAssertEqual(2, result)
  }

  func testGetNumberOfCirclesReachedForDate_whenAnotherDayIsGiven() {
    WalkUserDefaults.circlesReached.clear()
    WalkUserDefaults.lastCircleReachedDate_yearMonthDay.clear()

    // Increment the previous dat
    var date = iiDate.fromYearMonthDay(2027, month: 8, day: 22)!
    WalkCirlesReachedToday.increment(date)
    WalkCirlesReachedToday.increment(date)
    WalkCirlesReachedToday.increment(date)

    date = iiDate.fromYearMonthDay(2027, month: 8, day: 23)!

    var result = WalkCirlesReachedToday.number(date)

    XCTAssertEqual(0, result)

    // Now increment the next day
    WalkCirlesReachedToday.increment(date)
    WalkCirlesReachedToday.increment(date)

    result = WalkCirlesReachedToday.number(date)

    XCTAssertEqual(2, result)
  }
}
