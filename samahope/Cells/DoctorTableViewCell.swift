//
//  DoctorTableViewCell.swift
//  samahope
//
//  Created by Isaac Ho on 3/14/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var progressBar: FundingProgressBarView!
    @IBOutlet weak var doctorThumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var doctorMainImageView: UIImageView!
    @IBOutlet weak var treatmentImageView: UIImageView!
    @IBOutlet weak var focusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    private var doctor: Doctor?
    
    func setDoctor( newDoctor: Doctor ) {
        doctor = newDoctor
        nameLabel.text = doctor!.name
        locationLabel.text = "\(doctor!.location!)"
        focusLabel.text = "\(doctor!.treatment!.name!)"
        var treatmentCost = doctor!.amountFunded! + doctor!.amountNeeded!
        fundingProgressLabel.text = "$\(doctor!.amountFunded!) raised out of $\(treatmentCost)"
        var p = Double(doctor!.amountFunded!) / ( Double( treatmentCost ))
        progressBar.fillWithPercent( CGFloat(p) )
        
        let url = NSURL(string: doctor!.bannerPicUrl! )
        
        doctorMainImageView.setImageWithURL(url)
        
        let imageUrl = NSURL(string: doctor!.bannerPicUrl!)
        let bannerRequest = NSURLRequest(URL: imageUrl!)
        
        let placeholder = UIImage(named: "doctor-robert-thumbnail")
        
        let imageLoadSuccess = {
            (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                self.doctorMainImageView.image = image
            UIView.animateWithDuration(1, animations: {
                self.doctorMainImageView.alpha = 1
                
            })
        }
        doctorMainImageView.setImageWithURLRequest(bannerRequest, placeholderImage: placeholder, success: imageLoadSuccess, failure: nil)
        
        let url2 = NSURL(string: doctor!.thumbnailPicUrl! )
        doctorThumbnailView.setImageWithURL(url2)
        let url3 = NSURL(string: doctor!.treatment!.iconPicUrl!)
        treatmentImageView.setImageWithURL(url3)

        doctorThumbnailView.layer.cornerRadius = doctorThumbnailView.frame.height / 2
        doctorThumbnailView.clipsToBounds = true

    
    }

    override func awakeFromNib() {
        println( "tableViewCell.awakeFromNib")

        super.awakeFromNib()

        self.selectionStyle = UITableViewCellSelectionStyle.None;
        
        
        // Initialization code
        
    }
    @IBOutlet weak var fundingProgressLabel: UILabel!


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
