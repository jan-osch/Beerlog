//
//  BeerMapAnnotation.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 01.03.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class BeerAnnotation: NSObject, MKAnnotation {
    let title: String?
    let story: String
    let coordinate: CLLocationCoordinate2D
    var image: UIImage?
    let beer: Beer?
    
    init(beer: Beer) {
        self.title = beer.title!
        self.story = beer.story!
        self.coordinate = CLLocationCoordinate2D(latitude: beer.latitude! as Double, longitude: beer.longitude! as Double)
        if let beerImage = beer.image {
            self.image = UIImage(data: beerImage)
        }
        self.beer = beer
        super.init()
    }
    
    var subtitle: String? {
        return story
    }
}
