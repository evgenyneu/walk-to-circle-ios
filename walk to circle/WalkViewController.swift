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
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    showBackground()
  }
  
  @IBAction func onCancelTapped(sender: AnyObject) {
    WalkViewControllers.Map.show()
  }

  private func showBackground() {
    let image = UIImage(named: "branch_background_1242_2208.png")
    let imageView = UIImageView(image: image)
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
    view.insertSubview(imageView, atIndex: 0)

    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: true)
    iiAutolayoutConstraints.fillParent(imageView, parentView: view, margin: 0, vertically: false)
  }
}
