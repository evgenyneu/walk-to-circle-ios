import Foundation

public class iiDate {
  public class func toStringAsYearMonthDay(date: NSDate) -> String {
    let components = NSCalendar.currentCalendar().components(
      [NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year],
      fromDate: date)

    return "\(components.year).\(components.month).\(components.day)"
  }

  public class func fromYearMonthDay(year: Int, month: Int, day: Int) -> NSDate? {
    let dateComponents = NSDateComponents()

    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day

    return NSCalendar.currentCalendar().dateFromComponents(dateComponents)
  }
}
