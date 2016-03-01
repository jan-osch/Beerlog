//
//  MapViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 01.03.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        displayBeerData()
    }
    
    var detailBeer: Beer? {
        didSet{
            if let beer = detailBeer{
                clearMap()
                mapView.addAnnotation(BeerAnnotation(beer:beer))
                mapView.showAnnotations(mapView.annotations, animated: true)
            }
        }
    }
    
    func clearMap(){
        if mapView?.annotations != nil {
            mapView.removeAnnotations((mapView?.annotations)!)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func displayBeerData(){
        let allBeers:[Beer]  = BeerDao.getAllBeers()
        let locationBeers = prepareBeerAnnotations(allBeers)
        mapView.addAnnotations(locationBeers)
    }
    
    func prepareBeerAnnotations(allBeers:[Beer])->[BeerAnnotation]{
        var locationBeers = [BeerAnnotation]()
        for beer in allBeers{
            beer.latitude = 21.283921
            beer.longitude = -11.283921
            locationBeers.append(BeerAnnotation(beer: beer))
        }
        return locationBeers
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSegueIdentifier"{
            if let detailBeerVC = segue.destinationViewController as? BeerDetailTableTableViewController{
                if let beerAnnotation = (sender as? MKAnnotationView)?.annotation as? BeerAnnotation{
                    detailBeerVC.detailBeer = beerAnnotation.beer
                }
            }
        }
    }
}
