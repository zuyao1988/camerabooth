//
//  CustomOverlayView.swift
//  cameraBooth
//
//  Created by Zu Yao on 9/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit

protocol CustomOverlayDelegate{
    func didCancel(overlayView:CustomOverlayView)
    func didShoot(overlayView:CustomOverlayView)
}

class CustomOverlayView: UIView {
    
    @IBOutlet weak var cameraLabel: UILabel!
    var delegate:CustomOverlayDelegate! = nil
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func cancelButton(sender: UIButton) {
        cameraLabel.text = "I want to exit"
        delegate.didCancel(self)
    }
    @IBAction func shootButton(sender: UIButton) {
        cameraLabel.text = "Even Cooler Camera"
        delegate.didShoot(self)
    }
    
   

}
