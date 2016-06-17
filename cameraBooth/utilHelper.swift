//
//  utilHelper.swift
//  cameraBooth
//
//  Created by Zu Yao on 17/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
//    func correctlyOrientedImage() -> UIImage {
//        if self.imageOrientation == UIImageOrientation.Up {
//            print("what am up")
//            return self
//        } else if self.imageOrientation == UIImageOrientation.Down {
//            print("what am down")
//            return self
//        } else if self.imageOrientation == UIImageOrientation.Left {
//            print("what am left")
//            return self
//        } else if self.imageOrientation == UIImageOrientation.Right {
//            print("what am right")
//            return self
//        } else {
//            print("what am shit")
//            return self
//        }
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
//        var normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        return normalizedImage;
//    }
    
    //--------
//    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
//        let radiansToDegrees: (CGFloat) -> CGFloat = {
//            return $0 * (180.0 / CGFloat(M_PI))
//        }
//        let degreesToRadians: (CGFloat) -> CGFloat = {
//            return $0 / 180.0 * CGFloat(M_PI)
//        }
//        
//        // calculate the size of the rotated view's containing box for our drawing space
//        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
//        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
//        rotatedViewBox.transform = t
//        let rotatedSize = rotatedViewBox.frame.size
//        
//        // Create the bitmap context
//        UIGraphicsBeginImageContext(rotatedSize)
//        let bitmap = UIGraphicsGetCurrentContext()
//        
//        // Move the origin to the middle of the image so we will rotate and scale around the center.
//        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
//        
//        //   // Rotate the image context
//        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
//        
//        // Now, draw the rotated/scaled image into the context
//        var yFlip: CGFloat
//        
//        if(flip){
//            yFlip = CGFloat(-1.0)
//        } else {
//            yFlip = CGFloat(1.0)
//        }
//        
//        CGContextScaleCTM(bitmap, yFlip, -1.0)
//        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImage
//    }
}
