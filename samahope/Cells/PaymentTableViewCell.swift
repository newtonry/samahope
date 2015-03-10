//
//  PaymentTableViewCell.swift
//  samahope
//
//  Created by Ryan Newton on 3/10/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

//    These should be private
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var optionValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
