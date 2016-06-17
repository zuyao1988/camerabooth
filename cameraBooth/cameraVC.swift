//
//  cameraVC.swift
//  cameraBooth
//
//  Created by Zu Yao on 9/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit

class cameraVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CustomOverlayDelegate {

    var picker = UIImagePickerController()
//    var picker = abccb()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func takePicBtnPressed(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Front) != nil {
            //            picker = UIImagePickerController() //make a clean controller
            //            picker = CameraViewController()
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            
            picker.showsCameraControls = false
            picker.cameraDevice = .Front
            
            picker.modalPresentationStyle = .FullScreen
            
            //customView stuff
            let customViewController = CustomOverlayViewController(
                nibName:"CustomOverlayViewController",
                bundle: nil
            )
            let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
            customView.frame = self.picker.view.frame
            customView.cameraLabel.text = "Hello Cute Camera"
            customView.delegate = self
            
            presentViewController(picker,
                                  animated: true,
                                  completion: {
                                    self.picker.cameraOverlayView = customView
                }
            )
            
        } else { //no camera found -- alert the user.
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.Default,
                handler: nil)
            alertVC.addAction(okAction)
            presentViewController(
                alertVC,
                animated: true,
                completion: nil)
        }
    }
    
    //MARK: Picker Delegates
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        UIImageWriteToSavedPhotosAlbum(chosenImage, self,nil, nil)
    }
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
                                      completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func didCancel(overlayView:CustomOverlayView) {
        picker.dismissViewControllerAnimated(true,
                                             completion: nil)
    }
    func didShoot(overlayView:CustomOverlayView) {
        picker.takePicture()
//        picker.use
        overlayView.cameraLabel.text = "Shot Photo"

        
//        self.picker.cameraOverlayView = nil
//        picker.showsCameraControls = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("huhu")
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
