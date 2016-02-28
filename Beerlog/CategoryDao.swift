//
//  CategoryDao.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 28.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import Foundation
import CoreData

class CategoryDao{

    static func getAllCategories() -> [Category]{
        let managedObjectContext = CoreDataHelper.getManagedContext()
        let fetchRequest = NSFetchRequest(entityName: "Category")
        do{
            return try managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
        } catch {
            print("Could not fetch")
        }
        return [Category]()
    }
    
    static func createNewCategoryByName(name: String) {
        let managedObjectContext = CoreDataHelper.getManagedContext()
        let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: managedObjectContext)
        let category = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        category.setValue(name, forKey: "name")
        do{
            try managedObjectContext.save()
        }
        catch{
            print("Could not save")
        }
    }
}