//
//  DataStore.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit
import CoreData

class DataStore: NSObject {
    static let instance = DataStore()
    override fileprivate init() {}
    
    fileprivate var passResortArray = [Resort]()
    fileprivate var favResortArray = [Resort]()
    weak var managedObjectContext: NSManagedObjectContext!
    
    func resortAtIndex(_ index: Int) -> Resort? {
        if favResortArray.count >= 0 && index < favResortArray.count {
            return favResortArray[index]
        }
        return nil
    }

    func addResort(_ resort: Resort) {
        favResortArray.append(resort)
    }

    func numberOfResorts() -> Int {
        return favResortArray.count
    }

    func favIndex(_ index: Int) -> Resort? {
        if passResortArray.count >= 0 && index < self.passResortArray.count {
            return passResortArray[index]
        }
        return nil
    }

    func addFavResorts(_ resort: Resort) {
        passResortArray.append(resort)
    }

    func favNumberOfResorts() -> Int {
        return passResortArray.count
    }
}
