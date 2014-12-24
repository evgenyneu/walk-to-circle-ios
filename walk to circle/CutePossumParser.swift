//
//  CutePossumParser.swift
//  
//  Json parser for Swift. Handy for converting JSON into Swift structs.
//
//  Demo and examples:
//
//  https://github.com/exchangegroup/cute-possum-parser
//
//  Created by Evgenii Neumerzhitckii on 18/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import Foundation

private let cutePossumTopLevelObjectKey = "kutePossumTopLevelObjectKey#&"

public class CutePossumParser {
  var parent: CutePossumParser?
  private let data: NSDictionary
  
  public init(json: String) {
    let encoded = json.dataUsingEncoding(NSUTF8StringEncoding)

    if let currentEncoded = encoded {
      var error: NSError?

      let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(currentEncoded,
        options: .MutableContainers | .AllowFragments, error: &error)
      
      if error != nil {
        data = NSDictionary()
        reportFailure()
        return
      }
      
      if let parsed = parsedObject as? NSDictionary {
        data = parsed
      } else {
        if let parsed: AnyObject = parsedObject {
          data = [cutePossumTopLevelObjectKey: parsed]
        } else {
          data = NSDictionary()
          reportFailure()
        }
      }
    } else {
      data = NSDictionary()
      reportFailure()
    }
  }
  
  init(data: NSDictionary, parent: CutePossumParser? = nil) {
    self.data = data
    self.parent = parent
  }
  
  init(array: NSArray, parent: CutePossumParser? = nil) {
    data = [cutePossumTopLevelObjectKey: array]
    self.parent = parent
  }
  
  // Returns parser for the attribute
  public subscript(name: String) -> CutePossumParser {
    if let subData = data[name] as? NSDictionary {
      return CutePossumParser(data: subData, parent: self)
    } else {
      reportFailure()
      return CutePossumParser(data: NSDictionary(), parent: self)
    }
  }
  
  private var amISuccessful = true
  
  // Was parsing successful?
  public var success: Bool {
    get {
      if let currentParent = parent {
        return currentParent.success
      }
      return amISuccessful
    }
  }
  
  private func reportFailure() {
    parent?.reportFailure()
    amISuccessful = false
  }
  
  // Parses primitive value: String, Int, [String] etc.
  public func parse<T>(name: String, miss: T, canBeMissing: Bool = false) -> T {
    if !success { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    } else {
      if !canBeMissing { reportFailure() }
    }
    
    return miss
  }
  
  // Parses a top-level object: String, Int, [String] etc.
  public func parse<T: CollectionType>(miss: T, canBeMissing: Bool = false) -> T {
    if !success { return miss }
    
    return parse(cutePossumTopLevelObjectKey, miss: miss, canBeMissing: canBeMissing)
  }
  
  // Parses a value that is assigned to a Swift optional.
  public func parseOptional<T>(name: String, miss: T? = nil) -> T? {
    if !success { return miss }
    
    if let parsed = data[name] as? T {
      return parsed
    }
    
    return miss
  }
  
  // Parses a top-level array of items with custom parser function.
  public func parseArray<T: CollectionType>(miss: T, canBeMissing: Bool = false,
    parser: (CutePossumParser)->(T.Generator.Element)) -> T {
    
    return parseArray(cutePossumTopLevelObjectKey, miss: miss, parser: parser)
  }
  
  // Parses an array of items with custom parser function.
  public func parseArray<T: CollectionType>(name: String, miss: T, canBeMissing: Bool = false,
    parser: (CutePossumParser)->(T.Generator.Element)) -> T {
      
    if let items = data[name] as? NSArray {
      var parsedItems = Array<T.Generator.Element>()
      
      for item in items {
        var itemParser: CutePossumParser
        
        if let currentData = item as? NSDictionary {
          itemParser = CutePossumParser(data: currentData, parent: self)
        } else if let currentArray = item as? NSArray {
          itemParser = CutePossumParser(array: currentArray, parent: self)
        } else {
          if !canBeMissing { reportFailure() }
          return miss
        }
        
        let parsedValue = parser(itemParser)
        
        if success {
          parsedItems.append(parsedValue)
        } else {
          if !canBeMissing { reportFailure() }
          return miss
        }
      }
      
      if let result = parsedItems as? T { return result }
      
    } else {
      if !canBeMissing { reportFailure() }
    }
      
    return miss
  }
}
