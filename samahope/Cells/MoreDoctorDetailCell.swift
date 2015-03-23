//
//  MoreDoctorDetailCell.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MoreDoctorDetailCell: UITableViewCell {

    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var secondHeader: UILabel!
    
    @IBOutlet weak var textBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }
    
    func fillWithDescriptionAndImage(description: String, imageUrlString: String, secondHeader: String, textBody: String) {
        cellDescription.text = description
        cellImage.setImageWithURL(NSURL(string: imageUrlString))
        cellImage.layer.cornerRadius = cellImage.frame.height / 2
        cellImage.clipsToBounds = true
        
        self.secondHeader.text = secondHeader
        self.textBody.text = textBody
    }
    
    
}
