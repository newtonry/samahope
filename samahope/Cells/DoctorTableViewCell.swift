//
//  DoctorTableViewCell.swift
//  samahope
//
//  Created by Isaac Ho on 3/14/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorThumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationAndTreatmentLabel: UILabel!
    @IBOutlet weak var doctorMainImageView: UIImageView!
    @IBOutlet weak var treatmentImageView: UIImageView!
    
    @IBOutlet weak var fundingProgressView: UIProgressView!
   
    @IBAction func onPayClick(sender: AnyObject) {
    }
    
    private var doctor: Doctor?
    
    func setDoctor( newDoctor: Doctor ) {
        println( "setDoctor" )
        doctor = newDoctor
        nameLabel.text = doctor!.name
        locationAndTreatmentLabel.text = "\(doctor!.location!), \(doctor!.treatment!.name!)"
        fundingProgressLabel.text = "$\(doctor!.amountFunded!) raised out of $\(doctor!.amountNeeded!)"
        var p = Double(doctor!.amountFunded!) / Double( doctor!.amountNeeded! )
        fundingProgressView.setProgress( Float(p), animated:false )
        
        let url = NSURL(string: doctor!.bannerPicUrl! )
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        doctorMainImageView.image = UIImage(data: data!)
        
        let url2 = NSURL(string: doctor!.thumbnailPicUrl! )
        let data2 = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        doctorThumbnailView.image = UIImage(data: data2!)
        
        let url3 = NSURL(string: doctor!.treatment!.iconPicUrl!)
        let data3 = NSData(contentsOfURL: url3!)
        treatmentImageView.image = UIImage(data: data3!)
    
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
