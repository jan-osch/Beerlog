//
//  BeerTableViewCell.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 27.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var beerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBeer(beer:Beer){
        self.titleTextLabel.text = beer.title
        if beer.rating != nil{
            self.ratingImageView.image = ImageHelper.getImageForRating(beer.rating!.integerValue)
        }
        if beer.image != nil{
            self.beerImageView.image = UIImage(data: beer.image!)
        }
    }
}
