//
//  AppDelegate.swift
//  EPICvsIKON
//
//Users/jasonsanchez/Desktop/2018-19-Ski-Pass/EPICvsIKON/EPICvsIKON/entity/  Created by don't touch me on 3/1/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        deleteRecords()
        checkDataStore()
        
        let managedObjectContext = coreData.persistentContainer.viewContext
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        // First Tab - Resort List
        let resortListNavigationController = tabBarController.viewControllers?[0] as! UINavigationController
        let resortSwipeController = resortListNavigationController.topViewController as! ResortSwipeController
        resortSwipeController.managedObjectContext = managedObjectContext
        
        // Second Tab - Result View
        let resultNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
        let resultViewController = resultNavigationController.topViewController as! ResultController
        resultViewController.managedObjectContext = managedObjectContext
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        coreData.saveContext()
    }
    
    func checkDataStore() {
        let request: NSFetchRequest<Resort> = Resort.fetchRequest()
        
        let moc = coreData.persistentContainer.viewContext
        
        do {
            let resortCount = try moc.count(for: request)
            
            if resortCount == 0 {
                //ERROR
                uploadSampleData()
            }
        }
        catch {
            fatalError("Error in counting resort record")
        }
    }
    // ERROR
    func uploadSampleData() {
        let moc = coreData.persistentContainer.viewContext
        
        let url = Bundle.main.url(forResource: "resorts", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let jsonArray = jsonResult.value(forKey: "resort") as! NSArray
            
            for json in jsonArray {
                let resortData = json as! [String: AnyObject]
                
                //Resort
                guard let name = resortData["name"] else {
                    return
                }
                //Location
                guard let region = resortData["region"] else {
                    return
                }
                //Price
                guard let price = resortData["price"] else {
                    return
                }
                //Snow Fall
                guard let trueSnowfall = resortData["trueSnowfall"] else {
                    return
                }
                //Days to pay back pass
                guard let daysToPayBack = resortData["daysToPayBack"] else {
                    return
                }
                //Vertical Drop
                guard let verticalDrop = resortData["verticalDrop"] else {
                    return
                }
                //Airport to resort
                guard let airport = resortData["airport"] else {
                    return
                }
                //Picture
                var image: UIImage?
                if let currentImage = resortData["image"] {
                    let imageName = currentImage as? String
                    image = UIImage(named: imageName!)
                }
                
                var trailMapImage: UIImage?
                if let currentImage = resortData["trailMapImage"] {
                    let imageName = currentImage as? String
                    trailMapImage = UIImage(named: imageName!)
                }
                
                guard let resortCategory = resortData["category"] else {
                    return
                }
                let passType = (resortCategory as! NSDictionary)["passType"] as? String
                
                //Resort object initialization (polymorphism)
                let resort = passType?.caseInsensitiveCompare("Epic") == .orderedSame ? Epic(context: moc) : Ikon(context: moc)
                
                resort.name = name as? String
                resort.region = region as? String
                resort.price = price as! Double
                resort.trueSnowFall = trueSnowfall.int16Value
                resort.daysToPayBack = daysToPayBack.int16Value
                resort.verticalDrop = verticalDrop.int16Value
                resort.airport = airport.int16Value
                resort.image = NSData.init(data: UIImageJPEGRepresentation(image!, 1.0)!)
                resort.trailMapImage = NSData.init(data: UIImageJPEGRepresentation(trailMapImage!, 1.0)!)
                resort.passType = passType
            }
            coreData.saveContext()
        }
        catch {
            fatalError("Cannot upload sample data")
        }
    }
    
    func deleteRecords() {
        let moc = coreData.persistentContainer.viewContext
        let resortRequest: NSFetchRequest<Resort> = Resort.fetchRequest()
        
        var deleteRequest: NSBatchDeleteRequest
        var deleteResults: NSPersistentStoreResult
        
        do {
            deleteRequest = NSBatchDeleteRequest(fetchRequest: resortRequest as! NSFetchRequest<NSFetchRequestResult>)
            deleteResults = try moc.execute(deleteRequest)
        }
        catch {
            fatalError("Failed removing existing record")
        }
    }
}
