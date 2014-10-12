//
//  iiOutputView.swift
//
//  Created by Evgenii Neumerzhitckii on 11/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit

class iiOutputView {
  class func show(text: String) {
    if let viewConctroller = UIApplication.sharedApplication().delegate?.window??.rootViewController as? ViewController {
      viewConctroller.outputLabel.text = text
      viewConctroller.outputLabel.hidden = false
    }
  }
}


protocol iiOutputViewController {
  weak var outputLabel: UILabel! { get }
}