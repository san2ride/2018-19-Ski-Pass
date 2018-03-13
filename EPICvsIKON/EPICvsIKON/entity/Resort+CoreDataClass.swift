//
//  Resort+CoreDataClass.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/8/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Resort)
public class Resort: NSManagedObject {
    
    func getResortsByStatus(passType: String, moc: NSManagedObjectContext) -> [Resort] {
        let request: NSFetchRequest<Resort> = Resort.fetchRequest()
        request.predicate = NSPredicate(format: "passType = %@" , passType as CVarArg)
        
        do {
            let resorts = try moc.fetch(request)
            return resorts
        }
        catch {
            fatalError("")
        }
    }
}
