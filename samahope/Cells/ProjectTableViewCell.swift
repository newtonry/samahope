//
//  ProjectTableViewCell.swift
//  SamaHope
//
//  Created by Jeremy Hageman on 3/8/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit
import QuartzCore

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var docProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.docProfileImage.layer.cornerRadius = self.docProfileImage.frame.size.width / 2
        self.docProfileImage.clipsToBounds = true
        self.docProfileImage.layer.borderWidth = 2.0
        self.docProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
