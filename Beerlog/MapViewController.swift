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
        mapView.delegate = self
        displayBeerData()
    }
    
    var detailBeer: Beer? {
        didSet{
            print("detailBeer has been set")
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
        if let beerToDisplay = self.detailBeer {
            clearMap()
            mapView?.addAnnotation(BeerAnnotation(beer: beerToDisplay))
            
        }else{
            let allBeers:[Beer]  = BeerDao.getAllBeers()
            let locationBeers = prepareBeerAnnotations(allBeers)
            mapView.addAnnotations(locationBeers)
        }
        mapView?.showAnnotations(mapView.annotations, animated: true)
    }
    
    func prepareBeerAnnotations(allBeers:[Beer])->[BeerAnnotation]{
        var locationBeers = [BeerAnnotation]()
        for beer in allBeers{
            if beer.longitude != nil && beer.latitude != nil {
                locationBeers.append(BeerAnnotation(beer: beer))
            }
        }
        return locationBeers
    }
    
    // MARK: - Navigation
    
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
