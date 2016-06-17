//
//  ViewController.swift
//  cameraBooth
//
//  Created by Zu Yao on 8/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var shotBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var retakeBtn: UIButton!
    @IBOutlet weak var usePhotoBtn: UIButton!
    
    var tisCounter = 0
    
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        seedPerson()
//        fetchPerson()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.attempRotateCamera), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    @IBAction func takePhotoPressed(sender: UIButton!) {
        cameraBtn.hidden = true
        
        retakeBtn.hidden = true
        usePhotoBtn.hidden = true
        shotBtn.hidden = false
        cancelBtn.hidden = false
        
        initialCamera()
    }
    
    func initialCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPresetPhoto
        //        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error : NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil){
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if (captureSession?.canAddOutput(stillImageOutput) != nil){
                captureSession?.addOutput(stillImageOutput)
                
                print("\(cameraView.bounds)")
                previewLayer?.frame = cameraView.bounds
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill //AVLayerVideoGravityResizeAspect
                previewLayer?.position = CGPointMake(CGRectGetMidX(cameraView.bounds), CGRectGetMidY(cameraView.bounds))
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(previewLayer!)
                //                                self.view.layer.addSublayer(previewLayer!)
                
                self.view.sendSubviewToBack(cameraView)
                //                self.view.bringSubviewToFront(tempImageView)
                //                self.view.bringSubviewToFront(shotBtn)
                //                self.view.bringSubviewToFront(retakeBtn)
                //                self.view.bringSubviewToFront(cancelBtn)
                
                previewLayer?.frame = cameraView.bounds
                
                attempRotateCamera()
                
                captureSession?.startRunning()
            }
        }
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        imagePicker.dismissViewControllerAnimated(true, completion: nil)
//        let imgData = info[UIImagePickerControllerOriginalImage] as? UIImage
//
//        imageView.image = imgData
//        createImageGallery()
//    }
    
    @IBAction func capturePressed(sender: UIButton!) {
        retakeBtn.hidden = false
        usePhotoBtn.hidden = false
        shotBtn.hidden = true
        cancelBtn.hidden = true
        
        didPressTakePhoto()
    }
    
    @IBAction func cancelPressed(sender: UIButton!) {
        resetToDefaultScreen()
    }
    
    @IBAction func retakePressed(sender: UIButton!) {
        //camera running......
        captureSession?.startRunning()
        imageView.hidden = true

        retakeBtn.hidden = true
        usePhotoBtn.hidden = true
        shotBtn.hidden = false
        cancelBtn.hidden = false
    }
    
    var tmpImage: UIImage!
    @IBAction func usePhotoPressed(sender: UIButton!) {
        createImageGallery()
        imageView.hidden = true
        resetToDefaultScreen()
    }
    
    func resetToDefaultScreen() {
        self.captureSession?.stopRunning()
        self.previewLayer?.removeFromSuperlayer()
        self.previewLayer = nil
        self.captureSession = nil
        
        cameraBtn.hidden = false
        
        retakeBtn.hidden = true
        usePhotoBtn.hidden = true
        shotBtn.hidden = true
        cancelBtn.hidden = true
    }

    func didPressTakePhoto(){
        
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    self.tmpImage = self.rotateImage(cgImageRef!)
//                    self.tmpImage = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
//                    self.tmpImage = UIImage(CGImage: cgImageRef!)

                    self.imageView.image = self.tmpImage
                    self.imageView.hidden = false
                    self.captureSession?.stopRunning()
                    
                    self.view.sendSubviewToBack(self.imageView)
                }
            })
        }
    }
    
    func rotateImage(cgimg: CGImage) -> UIImage {
        let currentDevice: UIDevice = UIDevice.currentDevice()
        let orientation: UIDeviceOrientation = currentDevice.orientation
        let tmpImg: UIImage!
        
        switch (orientation)
        {
            case .Portrait:
                tmpImg = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Right)
                break
            case .PortraitUpsideDown:
                tmpImg = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Left)
                break
            default:
                tmpImg = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Up)
                break
        }
        return tmpImg
    }
    
    func createImageGallery() {
        tisCounter = tisCounter + 1
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("ImageGallery", inManagedObjectContext: context)!
        let imgGallery = ImageGallery(entity: entity, insertIntoManagedObjectContext: context)
        imgGallery.custid = "id\(tisCounter)"
        imgGallery.badgeName = "badge \(tisCounter)"
        imgGallery.company = "comp \(tisCounter)"
        imgGallery.setGalleryImage(imageView.image!)
        
        if tisCounter & 3 == 0 {
            imgGallery.isSaved = false
        } else {
            imgGallery.isSaved = true
        }
        
        context.insertObject(imgGallery)
        
        do {
            try context.save()
        } catch {
            fatalError("could not save imagGallery")
        }
        
//        let entity = NSEntityDescription.entityForName("ImageGallery", inManagedObjectContext: moc)!
//        let imgGallery = ImageGallery(entity: entity, insertIntoManagedObjectContext: moc)
//        imgGallery.custid = "id\(tisCounter)"
//        imgGallery.badgeName = "badge \(tisCounter)"
//        imgGallery.company = "comp \(tisCounter)"
//        imgGallery.setGalleryImage(imageView.image!)
//        
//        if tisCounter & 3 == 0 {
//            imgGallery.isSaved = false
//        } else {
//            imgGallery.isSaved = true
//        }
//        
//        moc.insertObject(imgGallery)
//        
//        do {
//            try moc.save()
//        } catch {
//            fatalError("could not save imagGallery")
//        }
    }
    
    func fetchPerson() {
//        let personFetch = NSFetchRequest(entityName: "Person")
//        
//        do {
//           let fetchedPerson = try moc.executeFetchRequest(personFetch) as! [Person]
//            print("Fetched : \(fetchedPerson.first?.firstName!)")
//        } catch {
//            fatalError("fatal error in fetch : \(error)")
//        }
    }
    
    func seedPerson() {
//        let entity = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: moc) as! Person
//        
//        entity.setValue("Miao", forKey: "firstName")
//        entity.setValue("Lee", forKey: "lastName")
//        
//        do {
//            try moc.save()
//            print("saved")
//        } catch {
//            fatalError("failure to save context: \(error)")
//        }
    }
    
    @IBAction func viewAllGalleryPressed(sender: AnyObject) {
    }
    
    func attempRotateCamera() {
        if let connection =  self.previewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.currentDevice()
            let orientation: UIDeviceOrientation = currentDevice.orientation

            let previewLayerConnection : AVCaptureConnection = connection

            if (previewLayerConnection.supportsVideoOrientation)
            {
                switch (orientation)
                {
                case .Portrait:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
                    break
//                case .LandscapeRight:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
//                    break
//                case .LandscapeLeft:
//                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
//                    break
                case .PortraitUpsideDown:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.PortraitUpsideDown
                    break
                default:
                    previewLayerConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
                    break
                }
            }
        }
    }
}

