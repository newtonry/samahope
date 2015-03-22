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
    @IBOutlet weak var locationAndTreatmentLabel: UILabel!
    @IBOutlet weak var doctorMainImageView: UIImageView!
    @IBOutlet weak var treatmentImageView: UIImageView!
    @IBAction func onPayClick(sender: AnyObject) {
    }
    
    private var doctor: Doctor?
    
    func setDoctor( newDoctor: Doctor ) {
        doctor = newDoctor
        nameLabel.text = doctor!.name
        locationAndTreatmentLabel.text = "\(doctor!.location!), \(doctor!.treatment!.name!)"
        fundingProgressLabel.text = "$\(doctor!.amountFunded!) raised out of $\(doctor!.amountNeeded!)"
        var p = Double(doctor!.amountFunded!) / Double( doctor!.amountNeeded! )
        progressBar.fillWithPercent( CGFloat(p) )
        
        let url = NSURL(string: doctor!.bannerPicUrl! )
        
        doctorMainImageView.setImageWithURL(url)
        
        let url2 = NSURL(string: doctor!.thumbnailPicUrl! )
        doctorThumbnailView.setImageWithURL(url2)
        let url3 = NSURL(string: doctor!.treatment!.iconPicUrl!)
        treatmentImageView.setImageWithURL(url3)
    }

    override func awakeFromNib() {
        println( "tableViewCell.awakeFromNib")

        super.awakeFromNib()
        // Initialization code
        
    }
    @IBOutlet weak var fundingProgressLabel: UILabel!


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
