//
//  ResortViewController.swift
//  EPICvsIKON
//
//  Created by Jason Sanchez on 9/16/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit
import CoreData

class ResortViewController: UIViewController, CardStackDelegate {

        @IBOutlet weak var cardStackView: CardStack!
        weak var managedObjectContext: NSManagedObjectContext!
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 42))
            imageView.contentMode = .scaleAspectFit
    
            let image = UIImage(named: "SNOCRU")
            imageView.image = image
    
            navigationItem.titleView = imageView
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            self.cardStackView.delegate = self
        }
    
        func cardInterested(resort: Resort) {
            DataStore.instance.addFavResorts(resort)
            print("interested")
        }
    
        func cardNotInterested(resort: Resort) {
            print("not interested")
        }

}
