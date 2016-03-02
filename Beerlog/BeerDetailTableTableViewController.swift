//
//  BeerDetailTableTableViewController.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 29.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit

class BeerDetailTableTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    
    var detailBeer: Beer?{
        didSet{
            configureView()
        }
    }
    
    func configureView() {
        if let detailBeer = detailBeer {
            if let titleLabel = titleLabel, mainImageView = mainImageView {
                titleLabel.text = detailBeer.title
                if let beerMainImage = detailBeer.image{
                    mainImageView.image = UIImage(data: beerMainImage)
                }
                ratingImageView.image = ImageHelper.getImageForRating(Int(detailBeer.rating!))
                categoryLabel.text = detailBeer.beerCategory?.name
                storyTextView.text = detailBeer.story
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editBeerSegue" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AddBeerTableViewController
            controller.previousBeer = detailBeer
        } else if segue.identifier == "GoToLocation" {
            if let controller = segue.destinationViewController as? MapViewController {
                controller.detailBeer = self.detailBeer
            }
        }
    }
}
