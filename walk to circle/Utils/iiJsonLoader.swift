import Foundation

public class iiJsonLoader {
  public class func read(filename: String) -> String? {
    if let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil) {
      return try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
    }

    return nil
  }
}
