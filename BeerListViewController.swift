//
//  BeerListViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 27.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit
import CoreData

class BeerListViewController: UIViewController, UITableViewDataSource {
    
    var beers = [Beer]()
    var categories = [Category]()
    var beerToDeleteIndexPath: NSIndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        title = "Beers"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].beers!.count 
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeerCell")! as! BeerTableViewCell
        cell.setBeer(getBeerByIndexPath(indexPath))
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            beerToDeleteIndexPath = indexPath
            let beerToDelete = getBeerByIndexPath(indexPath)
            confirmDelete(beerToDelete)
        }
    }
    
    func confirmDelete(beerToDelete: Beer) {
        let alert = UIAlertController(title: "Delete beer", message: "Are you sure you want to permanently delete \(beerToDelete.title!)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteBeer)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDelete)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteBeer(alertAction: UIAlertAction!) -> Void {
        if let indexPath = beerToDeleteIndexPath {
            tableView.beginUpdates()
            BeerDao.deleteBeer(getBeerByIndexPath(beerToDeleteIndexPath!))
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            beerToDeleteIndexPath = nil
            tableView.endUpdates()
        }
    }
    
    func cancelDelete(alertAction: UIAlertAction!) {
        beerToDeleteIndexPath = nil
    }
    
    func getBeerByIndexPath(indexPath: NSIndexPath) -> Beer{
        let beerSet = categories[indexPath.section].beers
        let beerArray = (beerSet?.allObjects)! as NSArray
        return beerArray[indexPath.row] as! Beer
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBeerDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let beer  = getBeerByIndexPath(indexPath)
                let controller = segue.destinationViewController as! BeerDetailTableTableViewController
                controller.detailBeer = beer
            }
        }
    }

    // MARK: - CoreData

    func fetchData()    {
        categories = CategoryDao.getAllCategories()
        tableView.reloadData()
    }
    
    @IBAction func cancelToBeersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveBeer(segue:UIStoryboardSegue) {
    }
    
}
