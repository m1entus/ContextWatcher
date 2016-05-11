//
//  ViewController.swift
//  ContextWatcher
//
//  Created by Michal Zaborowski on 10.05.2016.
//  Copyright © 2016 Inspace Labs Sp z o. o. Spółka Komandytowa. All rights reserved.
//

import UIKit
import CoreData
import AlecrimCoreData

extension NSManagedObjectContext {
    @nonobjc static var defaultContext: DataContext = {
        let url = NSBundle.mainBundle().URLForResource("ContextWatcher", withExtension: "momd")!
        do {
            return DataContext(dataContextOptions: try DataContextOptions(managedObjectModelURL: url))
        } catch {
            abort()
        }
    }()
}


class ViewController: UIViewController {

    var observer: CoreDataContextObserver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = CoreDataContextObserver(context: NSManagedObjectContext.defaultContext)

        observer?.contextChangeBlock = { notification, changes in
            let insertedChanges = changes.filter({ change in
                switch change {
                    case .Inserted(_): return true
                    default: return false
                }
            })
            if let insertedJournal = insertedChanges.filter({ $0.managedObject() is Journal }).first?.managedObject() as? Journal {
                print("INSERTED: \(insertedJournal)")
            }
        }
        
        let journal = Journal.createExampleJournal()
        
        
        observer?.observeObject(journal, state: .Updated, completionBlock: { object, state in
            print("CHANGED VALUES: \(object.changedValuesForCurrentEvent())")
        })
        
        observer?.observeObject(journal, state: .Deleted, completionBlock: { object, state in
            print("OBJECT DELETED")
        })
        
        let delayTime2 = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime2, dispatch_get_main_queue()) {
            journal.delete()
        }
        
        journal.name = "123"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
