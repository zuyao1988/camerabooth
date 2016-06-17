//
//  Person+CoreDataProperties.swift
//  cameraBooth
//
//  Created by Zu Yao on 8/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var company: String?

}
