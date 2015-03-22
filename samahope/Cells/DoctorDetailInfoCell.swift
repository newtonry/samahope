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
    
    private var bannerImageOriginalFrame: CGRect?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerImageOriginalFrame = bannerImage.frame
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithProject(project: Project) {
        let bannerUrl = NSURL(string: project.doctorBanner!)

//        bannerImage.setImageWithURL(bannerUrl!)
        
        project.loadBannerIntoImageViewAsnync({(image: UIImage)-> Void in
            self.bannerImage.image = image            
        })
        
        doctorName.text = project.doctorName!
        leftCircleTitleView.setWithImageAndTitle(UIImage(named: "map-marker")!, title: project.location!)
        rightCircleTitleView.setWithImageStringAndTitle(project.treatmentImage!, title: project.treatmentName!)
    }

    
    func increaseBannerSizeByRatio(ratio: CGFloat) {
        var newWidth =  ratio * bannerImageOriginalFrame!.width
        var newHeight = ratio * bannerImageOriginalFrame!.height
        var newXorigin =  bannerImageOriginalFrame!.origin.x - (newWidth - bannerImageOriginalFrame!.width)/2  // To keep it centered
        let newFrame = CGRect(x: newXorigin, y: bannerImageOriginalFrame!.origin.y, width: newWidth, height: newHeight)
        bannerImage.frame = newFrame
    }
    
    func animateBannerBackToNormal() {
        UIView.animateWithDuration(0.1, animations: {
            self.bannerImage.frame = self.bannerImageOriginalFrame!
        })
        
    }
    

}
