//
//  DataStore.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/2/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit

class DataStore: NSObject {
    static let instance = DataStore()
    override fileprivate init() {}
    
    fileprivate var passResortArray = [Resort]()
    fileprivate var favResortArray = [Resort]()
    
    func seedResorts() {
        let Vail = Resort(name: "Vail", pass: "Epic", region: "Rockies", days: "10 Total", price: "879.0", imageName: "vail")
        self.addResort(Vail)
        
        let SquawValley = Resort(name: "Squaw Valley", pass: "Ikon", region: "West", days: "7 Total", price: "899.0", imageName: "squawvalley_alpinemeadows")
        self.addResort(SquawValley)
        
        let DeerValley = Resort(name: "Deer Valley", pass: "Ikon", region: "Rockies", days: "7 Total", price: "899.0", imageName: "deervalley")
        self.addResort(DeerValley)
        
        let Heavenly = Resort(name: "Heavenly", pass: "Epic", region: "West", days: "Unlimited", price: "899.0", imageName: "heavenly")
        self.addResort(Heavenly)
        
        let JacksonHole = Resort(name: "Jackson Hole", pass: "Ikon", region: "Rockies", days: "7 Total", price: "899.0", imageName: "jacksonhole")
        self.addResort(JacksonHole)
        
        let ParkCity = Resort(name: "Park City", pass: "Epic", region: "Rockies", days: "Unlimited", price: "879.0", imageName: "parkcity")
        self.addResort(ParkCity)
        
        let Revelstoke = Resort(name: "Revelstoke", pass: "Ikon", region: "Canada", days: "7 Total", price: "899.0", imageName: "revelstoke")
        self.addResort(Revelstoke)
        
        let Steamboat = Resort(name: "Steamboat", pass: "Ikon", region: "West", days: "7 Total", price: "899.0", imageName: "steamboat")
        self.addResort(Steamboat)
        
        let Telluride = Resort(name: "Telluride", pass: "Epic", region: "Rockies", days: "10 Total", price: "879.0", imageName: "telluride")
        self.addResort(Telluride)
        
        let WhistlerBlackcomb = Resort(name: "Whistler Blackcomb", pass: "Epic", region: "Canada", days: "10 Total", price: "879.0", imageName: "whistler_blackcomb")
        self.addResort(WhistlerBlackcomb)
    }
    
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
