//
//  viewAllVC.swift
//  cameraBooth
//
//  Created by Zu Yao on 8/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit
import CoreData

class viewAllVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var imgGallerys = [ImageGallery]()
    var persons = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let personFetch = NSFetchRequest(entityName: "ImageGallery")
        
        do {
            let results = try context.executeFetchRequest(personFetch) as! [ImageGallery]
            self.imgGallerys = results
        } catch {
            fatalError("fatal error in fetch : \(error)")
        }
    }
    
    //table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("1.....")
        if let cell = tableView.dequeueReusableCellWithIdentifier("GalleryCell") as? GalleryCell {
            
            let imgGallery = self.imgGallerys[indexPath.row]
            
            cell.configureCell(imgGallery, idx: "\(indexPath.row)")
            return cell
        } else {
            return GalleryCell()
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imgGallerys.count
    }
}
