//
//  PlacePin.swift
//
//  Class function that place pin on the map
//
//  Created by Evgenii Neumerzhitckii on 12/10/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import MapKit

class DropPin {
  class func placeCircleOnMapAndAnimate(mapView: MKMapView, coordinate: CLLocationCoordinate2D,
    annotations: Annotations) {

    let annotationTitle = NSLocalizedString("Memorize & walk here",
      comment: "Annotation title shown above the pin on the map")

    let annotationSubtitle = NSLocalizedString("The map will close in 60 sec",
      comment: "Annotation title shown above the pin on the map")

    let annotation = annotations.add(coordinate, id: annotationTitle,
      subtitle: annotationSubtitle)

    mapView.selectAnnotation(annotation, animated: true)
    Annotation.hideCalloutAfterDelay(mapView, annotation: annotation, delay: 5)
  }

  class func playPinDropSound(pindDropHeight: CGFloat) {
    if pindDropHeight == 0 { return }

    if pindDropHeight > 200 {
      iiSounds.shared.play(iiSoundType.fall, atVolume: 0.01)
    }

    var showPinAfterDelay = pow(Double(pindDropHeight) / 1200.0, 2.5)

    if showPinAfterDelay < 0.2 { showPinAfterDelay = 0.2 }

    iiQ.runAfterDelay(showPinAfterDelay) {
      iiSounds.shared.play(iiSoundType.ballBounce, atVolume: 0.5)
    }
  }
}
