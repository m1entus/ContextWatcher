//
//  Journal.swift
//  ContextWatcher
//
//  Created by Michal Zaborowski on 10.05.2016.
//  Copyright © 2016 Inspace Labs Sp z o. o. Spółka Komandytowa. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

@objc(Journal)
class Journal: NSManagedObject {

    class func createExampleJournal() -> Journal {
        let journalTable = Table<Journal>(dataContext: NSManagedObjectContext.defaultContext)
        let journal = journalTable.createEntity()
        journal.name = "test"
        
        let pageTable = Table<Page>(dataContext: NSManagedObjectContext.defaultContext)
        let page1 = pageTable.createEntity()
        page1.position = 0
        page1.journal = journal
        
        let page2 = pageTable.createEntity()
        page2.position = 1
        page2.journal = journal
        
        return journal
    }
}
