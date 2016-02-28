//
//  ViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 24.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var counter = 1
    @IBAction func saveUser(sender: AnyObject) {
        print("Save button pressed: \(counter++) \(userNameTextField.text!) \(userPasswordTextField.text!)")
        
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        newUser.setValue(userNameTextField.text, forKey: "userName")
        newUser.setValue(userPasswordTextField.text, forKey: "password")
        
        do {
            try context.save()
        }catch{
            print("There was an error saving data")
        }
    }
    
    @IBAction func loadUser(sender: AnyObject) {
        print("Load button pressed: \(counter++)")
        let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Users")
        do{
            let results = try context.executeFetchRequest(request)
            if results.count > 0{
                for item in results as! [NSManagedObject]{
                    userNameTextField.text = item.valueForKey("userName") as? String
                    userPasswordTextField.text = item.valueForKey("password") as? String
                }
            }
        }
        catch{
            print("There was an error saving data")
        }
    }
}

