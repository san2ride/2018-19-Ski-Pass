//
//  Resort+CoreDataProperties.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/8/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//
//

import Foundation
import CoreData


extension Resort {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resort> {
        return NSFetchRequest<Resort>(entityName: "Resort")
    }

    @NSManaged public var airport: Int16
    @NSManaged public var daysToPayBack: Int16
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?
    @NSManaged public var passType: String?
    @NSManaged public var price: Double
    @NSManaged public var region: String?
    @NSManaged public var trailMapImage: NSData?
    @NSManaged public var trueSnowFall: Int16
    @NSManaged public var verticalDrop: Int16

}
