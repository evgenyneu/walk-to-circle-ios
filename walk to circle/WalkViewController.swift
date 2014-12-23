//
//  WalkViewController.swift
//  walk-to-circle
//
//  Created by Evgenii Neumerzhitckii on 7/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class WalkViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let image = UIImage(named: "background.png")
    let imageView = UIImageView(image: image)
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    view.insertSubview(imageView, atIndex: 0)

    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: true)
    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: false)
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    WalkViewControllers.Map.show()
  }
}
