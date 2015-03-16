//
//  DoctorDetailInfoCell.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorDetailInfoCell: UITableViewCell {

    
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var supportersCountLabel: UILabel!
    

    @IBOutlet weak var leftCircleTitleView: CircleTitleView!
    
    @IBOutlet weak var rightCircleTitleView: CircleTitleView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithProject(project: Project) {
        let bannerUrl = NSURL(string: project.doctorBanner!)
        bannerImage.setImageWithURL(bannerUrl!)
        doctorName.text = project.doctorName!
        leftCircleTitleView.setWithImageAndTitle(UIImage(named: "map-marker")!, title: project.location!)
        rightCircleTitleView.setWithImageStringAndTitle(project.treatmentImage!, title: project.treatmentName!)
    }
    

}
