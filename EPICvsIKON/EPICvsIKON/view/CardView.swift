//
//  CardView.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit
import CoreData

class CardView: UIView {
    weak var managedObjectContext: NSManagedObjectContext!
    var resort: Resort! {
        didSet {
            nameLabel.text = resort.name
            passLabel.text = resort.passType
            imageName.image = UIImage(data: resort.image! as Data)
        }
    }

    let nameLabel = UILabel()
    let passLabel = UILabel()
    let imageName = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
        setUpView()
    }

    func defaultInit() {
        self.backgroundColor = UIColor.white
        
        for v in [nameLabel, passLabel, imageName] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
    
        
        //Name
        NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: imageName, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        //Pass
        NSLayoutConstraint(item: passLabel, attribute: .top, relatedBy: .equal, toItem: imageName, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: passLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -7).isActive = true
        NSLayoutConstraint(item: passLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        //Image View
        NSLayoutConstraint(item: imageName, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageName, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageName, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0).isActive = true
    }
    
    func setUpView() {
        nameLabel.font = UIFont(name: "AvenirNext", size: 42)
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = .left
        
        passLabel.font = UIFont(name: "AvenirNext", size: 64)
        passLabel.textColor = UIColor.black
        passLabel.textAlignment = .right
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.imageName.contentMode = .scaleAspectFit
        self.imageName.clipsToBounds = true
    }
}
