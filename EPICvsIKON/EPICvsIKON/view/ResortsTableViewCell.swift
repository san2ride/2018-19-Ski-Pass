//
//  ResortsTableViewCell.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit

class ResortsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resortLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var trueSnowLabel: UILabel!
    @IBOutlet weak var daysToPayBackLabel: UILabel!
    @IBOutlet weak var verticalDropLabel: UILabel!
    @IBOutlet weak var resortImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(resort: Resort) {
        resortLabel.text = resort.name
        categoryLabel.text = resort.passType
        trueSnowLabel.text = String(resort.trueSnowFall)
        daysToPayBackLabel.text = String(resort.daysToPayBack)
        verticalDropLabel.text = String(resort.verticalDrop)
        
        let image = UIImage(data: resort.image! as Data)
        resortImageView.image = image
        resortImageView.layer.borderWidth = 1
        resortImageView.layer.cornerRadius = 4
    }

}
