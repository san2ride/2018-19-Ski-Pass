//
//  FavoriteResortController.swift
//  EPICvsIKON
//
//  Created by don't touch me on 3/10/18.
//  Copyright © 2018 trvl, LLC. All rights reserved.
//

import UIKit
import CoreData

class FavoriteResortController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return resort = Resort(context: managedObjectContext)
        }
    }
    
    // MARK: Initialization
    
    lazy var resorts = [Resort]()
    var selectedResort: Resort?
    var resort: Resort? = nil
    var passType: String = "passType"
    var sortDescriptor = [NSSortDescriptor]()
    var searchPredicate: NSPredicate?
    var request: NSFetchRequest<Resort>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request = Resort.fetchRequest()
        
//        loadData()
    }
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
//        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
//        passType = selectedValue == "Epic" ? [0] : "Ikon" [1]
//        loadData()
    }
    
    // MARK: tableView dataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resorts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resortCell", for: indexPath) as! ResortsTableViewCell
        
        let currentResort = resorts[indexPath.row]
        cell.configureCell(resort: currentResort)
        
        return cell
    }

    // MARK: Private function
    
    private func loadData() {
        resorts = resort!.getResortsByStatus(passType: passType, moc: managedObjectContext)
        tableView.reloadData()
//        var predicates = [NSPredicate]()
//
//        if let additionalPredicate = searchPredicate {
//            predicates.append(additionalPredicate)
//        }
//
//        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicates)
//
//        request!.predicate = predicate
//
//        if sortDescriptor.count > 0 {
//            request!.sortDescriptors = sortDescriptor
//        }

    }
}

