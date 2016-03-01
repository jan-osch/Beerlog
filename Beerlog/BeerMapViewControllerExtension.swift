//
//  BeerMapViewControllerExtension.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 01.03.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import Foundation
import MapKit
import UIKit

extension MapViewController: MKMapViewDelegate {
    
    private struct Constants{
        static let identifier = "pin"
        static let LeftCalloutFrame = CGRect(x:0, y:0, width: 59, height: 59)
        static let ShowBeerSegueIdentifier = "ShowSegueIdentifier"
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? BeerAnnotation {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(Constants.identifier) as? MKPinAnnotationView
            if view == nil{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.identifier)
                view?.canShowCallout = true
            }else{
                view!.annotation = annotation
            }
            view!.calloutOffset = CGPoint(x: -5, y: 5)
            view!.leftCalloutAccessoryView = UIImageView(frame: Constants.LeftCalloutFrame)
            view!.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView
            return view
        
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let thumbnailImageView = view.leftCalloutAccessoryView as? UIImageView {
            if let beerAnnotation = view.annotation as? BeerAnnotation{
                thumbnailImageView.image = beerAnnotation.image
            }
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegueWithIdentifier(Constants.ShowBeerSegueIdentifier, sender: view)
    }
}