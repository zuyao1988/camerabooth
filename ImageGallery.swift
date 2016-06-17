//
//  ImageGallery.swift
//  cameraBooth
//
//  Created by Zu Yao on 8/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ImageGallery: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    func setGalleryImage(img: UIImage) {
        let data = UIImageJPEGRepresentation(img, 0.8)
//        let data = UIImageJPEGRepresentation(img, 0.8)
        self.image = data
    }
    
    func getGalleryImage() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
}
