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
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        title = "Beers"
        beersTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var beersTableView: UITableView!
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("Called number of sections")
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
        let beerSet = categories[indexPath.section].beers
        let beerArray = (beerSet?.allObjects)! as NSArray
        cell.setBeer(beerArray[indexPath.row] as! Beer)
        return cell
    }
    override func viewDidAppear(animated: Bool) {
        fetchData()
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func fetchData()    {
        categories = CategoryDao.getAllCategories()
        tableView.reloadData()
    }
    
    @IBAction func cancelToBeersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveBeer(segue:UIStoryboardSegue) {
    }
    
}
