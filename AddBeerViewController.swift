//
//  AddBeerViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 27.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit
import CoreData

class AddBeerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var ratingTextLabel: UILabel!
    var categories = ["IPA", "Weizen", "Lager"]
    var chosenCategory : String?
    
    func saveBeer() {
        print("got saveBeer action")
        print("Category that will be saved : \(chosenCategory)")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Beer", inManagedObjectContext: managedContext)
        let beer = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        beer.setValue(titleTextField.text, forKey: "title")
        beer.setValue(descriptionTextField.text, forKey: "story")
        beer.setValue(5, forKey: "rating")
        
        do{
            try managedContext.save()
        }
        catch{
            print("Could not save")
        }
        
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.chosenCategory = categories[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SaveBeer" {
            saveBeer()
        }
    }
    
    
}
