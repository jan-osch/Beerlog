//
//  Beer+CoreDataProperties.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 28.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beer {

    @NSManaged var title: String?
    @NSManaged var story: String?
    @NSManaged var rating: NSDecimalNumber?
    @NSManaged var image: NSData?
    @NSManaged var beerCategory: Category?

}
