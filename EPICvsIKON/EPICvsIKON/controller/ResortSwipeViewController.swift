//
//  ResortSwipeViewController.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit

class ResortSwipeViewController: UIViewController, CardStackDelegate {

    @IBOutlet weak var cardStackView: CardStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStackView.delegate = self

    }
    
    func cardInterested(resort: Resort) {
        DataStore.instance.addFavResorts(resort)
        print("interested")
    }
    
    func cardNotInterested(resort: Resort) {
        print("not interested")
    }
}
