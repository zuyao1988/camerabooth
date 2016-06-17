//
//  DataService.swift
//  cameraBooth
//
//  Created by Zu Yao on 16/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance =  DataService()
    
    private var _currentImage: UIImage!
    
    var currentImage: UIImage {
        get {
            return _currentImage
        }
        set(newVal) {
           _currentImage = newVal
        }
    }
    
}
