//
//  ImageHelper.swift
//  Beerlog
//
//  Created by Janusz Grzesik on 28.02.2016.
//  Copyright © 2016 jg. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    static func getImageForRating(rating: Int) -> UIImage?{
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
}