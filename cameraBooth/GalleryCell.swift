//
//  GalleryCell.swift
//  cameraBooth
//
//  Created by Zu Yao on 8/6/16.
//  Copyright © 2016 Zu Yao. All rights reserved.
//

import UIKit
import Haneke

class GalleryCell: UITableViewCell {

    @IBOutlet weak var custidLbl: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var isSavedImg: UIImageView!
    @IBOutlet weak var galleryImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // cached key should be unique, idx might not be a good idea.
    func configureCell(imgGallery: ImageGallery, idx: String){
        print(imgGallery)
        print(imgGallery.company)
        custidLbl.text = imgGallery.custid
        name.text = imgGallery.badgeName
        company.text = imgGallery.company
        
        if imgGallery.isSaved == true {
            isSavedImg.image = UIImage(named: "tick")
        } else {
            isSavedImg.image = UIImage(named: "close")
        }
        
        let imgData = imgGallery.getGalleryImage()
//        galleryImg.image = imgData
        
        galleryImg.hnk_setImage(imgData, key: idx)
        
//        rotatedPhoto = rotatedPhoto?.imageRotatedByDegrees(90, flip: false)
        
        
//        } else {
//            isSavedImg.image = UIImage(named: "close")
//        }
    }

}
