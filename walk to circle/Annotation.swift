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

}

// MapView Delegate
// ------------------------------

typealias Ext_MapViewDelegate_Overlay = ViewController

extension Ext_MapViewDelegate_Overlay {
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) ->
    MKOverlayRenderer! {

      if overlay.isKindOfClass(Annotation) {
        let aRenderer =  MKCircleRenderer(circle: overlay as Annotation)
        aRenderer.fillColor =  UIColor(red: 255 / 255, green: 217 / 255, blue: 14 / 255, alpha: 0.4)
        aRenderer.strokeColor = UIColor.whiteColor()
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

      if let pinAnnoration = annotationView as? MKPinAnnotationView {
        pinAnnoration.animatesDrop = true
      }

      annotationView.canShowCallout = true
    }
    annotationView.annotation = annotation
    return annotationView
  }
}