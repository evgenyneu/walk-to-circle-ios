//
//  MyAnnotation.swift
//  Geo Regions Test
//
//  Created by Evgenii Neumerzhitckii on 21/06/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import MapKit
import CoreLocation

class Annotation: MKCircle {
  var newPin: Bool = false

  class func showCalloutAfterDelay(mapView: MKMapView,
    annotation: MKAnnotation, delay: Double, callback: (() -> ())? = nil) {

    iiQ.runAfterDelay(delay) {
      mapView.selectAnnotation(annotation, animated: false)
      callback?()
    }
  }

  class func hideCalloutAfterDelay(mapView: MKMapView, annotation: MKAnnotation, delay: Double) {
    iiQ.runAfterDelay(delay) {

      mapView.deselectAnnotation(annotation, animated: false)
    }
  }

  var animatesDrop: Bool {
    return newPin
  }

  var pinColor: MKPinAnnotationColor {
    return newPin ? MKPinAnnotationColor.Red : MKPinAnnotationColor.Green
  }

  var overlayFillColor: UIColor {
    return UIColor(red: 255 / 255, green: 217 / 255, blue: 14 / 255, alpha: 0.4)
  }

  var overlayStrokeColor: UIColor {
    return UIColor.whiteColor()
  }
}

// MapView Delegate
// ------------------------------

typealias Ext_MapViewDelegate_Overlay = YiiMap

extension Ext_MapViewDelegate_Overlay {
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) ->
    MKOverlayRenderer! {

    if let currentAnnotation = overlay as? Annotation {
      let aRenderer =  MKCircleRenderer(circle: currentAnnotation)
      aRenderer.fillColor = currentAnnotation.overlayFillColor
      aRenderer.strokeColor = currentAnnotation.overlayStrokeColor
      aRenderer.lineWidth = 2;

      return aRenderer;
    }
    
    return nil
  }

  func mapView(mapView: MKMapView!,
    viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {

    if annotation.isKindOfClass(MKUserLocation) { return nil }

    var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("MapVC")

    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MapVC")
      annotationView.canShowCallout = true
    } else {
      // Sometimes the reused pin annotation view already has a callout subview
      // which results in displaying two or more callouts above the pin.
      // To prevent it - remove all existing subviews from annotation.
      for view in annotationView.subviews {
        view.removeFromSuperview()
      }
    }

    if let pinAnnoration = annotationView as? MKPinAnnotationView {
      if let currentAnnotation = annotation as? Annotation {
        pinAnnoration.animatesDrop = currentAnnotation.animatesDrop
        pinAnnoration.pinColor = currentAnnotation.pinColor
      }
    }

    annotationView.annotation = annotation
    annotationView.setSelected(false, animated: false)
    return annotationView
  }
}