//
//  Journal+CoreDataProperties.swift
//  ContextWatcher
//
//  Created by Michal Zaborowski on 10.05.2016.
//  Copyright © 2016 Inspace Labs Sp z o. o. Spółka Komandytowa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Journal {

    @NSManaged var name: String?
    @NSManaged var pages: NSSet?

}
