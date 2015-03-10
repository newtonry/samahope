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

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var docProfileImage: UIImageView!
    
    let gradient : CAGradientLayer = CAGradientLayer()
    let transparent: UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.gradientView.backgroundColor = transparent
        self.gradient.colors = [
            transparent.CGColor,
            UIColor.blackColor().CGColor
        ]
        self.gradient.frame = gradientView.bounds
        gradientView.layer.insertSublayer(gradient, atIndex: 0)
        
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
