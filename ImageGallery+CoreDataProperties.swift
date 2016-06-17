//
//  ImageGallery+CoreDataProperties.swift
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

extension ImageGallery {

    @NSManaged var custid: String?
    @NSManaged var badgeName: String?
    @NSManaged var company: String?
    @NSManaged var image: NSData?
    @NSManaged var isSaved: NSNumber?

}
