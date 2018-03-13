//
//  Double+Extension.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/12/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import Foundation

extension Double {
    var decimalFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
