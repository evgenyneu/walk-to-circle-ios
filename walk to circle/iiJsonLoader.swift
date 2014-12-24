//
//  TestJsonLoader.swift
//  swippi
//
//  Created by Evgenii Neumerzhitckii on 24/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import Foundation

public class iiJsonLoader {
  public class func read(filename: String) -> String? {
    if let path = NSBundle.mainBundle().pathForResource(filename, ofType: nil) {
      return String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
    }

    return nil
  }
}
