//
//  Beer+CoreDataProperties.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 01.03.2016.
//  Copyright © 2016 jg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beer {

    @NSManaged var image: NSData?
    @NSManaged var rating: NSDecimalNumber?
    @NSManaged var story: String?
    @NSManaged var title: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var beerCategory: Category?

}
