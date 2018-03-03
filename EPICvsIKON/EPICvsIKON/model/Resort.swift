//
//  Resort.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit

class Resort: NSObject {
    
    var name: String
    var pass: String
    var region: String
    var days: String
    var price: String
    var imageName: String
    var image: UIImage? {
        return UIImage(named: self.imageName)
    }
    
    init(name: String, pass: String, region: String, days: String, price: String, imageName: String) {
        
        self.name = name
        self.pass = pass
        self.region = region
        self.days = days
        self.price = price
        self.imageName = imageName
    }
}
