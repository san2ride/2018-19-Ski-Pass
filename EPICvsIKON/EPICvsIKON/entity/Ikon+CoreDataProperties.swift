//
//  Ikon+CoreDataProperties.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/8/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//
//

import Foundation
import CoreData


extension Ikon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ikon> {
        return NSFetchRequest<Ikon>(entityName: "Ikon")
    }


}
