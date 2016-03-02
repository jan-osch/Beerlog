//
//  BeerDao.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 28.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BeerDao{
    static func saveBeer(title: String, story: String, rating: Int, category: Category, longitude: Double?, latitude: Double?, imageData: NSData?){
        let managedContext = CoreDataHelper.getManagedContext()
        let entity = NSEntityDescription.entityForName("Beer", inManagedObjectContext: managedContext)
        let beer = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        beer.setValue(title, forKey: "title")
        beer.setValue(story, forKey: "story")
        beer.setValue(rating, forKey: "rating")
        beer.setValue(category, forKey: "beerCategory")
        
        if let longitude = longitude {
            beer.setValue(longitude, forKey: "longitude")
        }
        if let latitude = latitude {
            beer.setValue(latitude, forKey: "latitude")
        }
        
        if imageData != nil{
            beer.setValue(imageData, forKey: "image")
        }
        
        let beers = category.mutableSetValueForKey("beers")
        beers.addObject(beer)
        
        do{
            try managedContext.save()
        }
        catch{
            print("Could not save")
        }
    }
    
    static func getAllBeers()-> [Beer]{
        let managedObjectContext = CoreDataHelper.getManagedContext()
        
        let fetchRequest = NSFetchRequest(entityName: "Beer")
        do{
            return try managedObjectContext.executeFetchRequest(fetchRequest) as! [Beer]
        } catch {
            print("Could not fetch ")
        }
        return [Beer]()
    }
    
    static func updateBeer(beer:Beer, previousCategory:Category){
        let managedContext = CoreDataHelper.getManagedContext()
        if previousCategory != beer.beerCategory{
            let beers = previousCategory.mutableSetValueForKey("beers")
            beers.removeObject(beer)
            let newBeers = beer.beerCategory!.mutableSetValueForKey("beers")
            newBeers.addObject(beer)
        }
        do{
            try managedContext.save()
        }
        catch{
            print("Could not save")
        }
    }
}