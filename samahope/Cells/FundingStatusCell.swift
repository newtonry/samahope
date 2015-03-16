//
//  FundingStatusCell.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class FundingStatusCell: UITableViewCell {

    
    
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var amountRaisedLabel: UILabel!
    @IBOutlet weak var treatmentStats: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0.976, green: 0.973, blue: 0.969, alpha: 1.0)
        self.progressBar.backgroundColor = UIColor(red: 0.949, green: 0.941, blue: 0.929, alpha:1.0)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setWithStats(treatmentsFulfilled: Int, treatmentsGoal: Int, amountRaised: Int, amountPerProcedure: Int) {
        
        
        treatmentStats.text = "Treatment \(treatmentsFulfilled) of \(treatmentsGoal) needed"
        amountRaisedLabel.text = "$\(amountRaised) raised of $\(amountPerProcedure)"

        let percComplete = CGFloat(amountRaised) / CGFloat(amountPerProcedure)
        let progressFillWidth = progressBar.frame.width * percComplete
        
        var progressFillFrame = CGRect(x: 0, y: 0, width: progressFillWidth, height: progressBar.frame.height)
        let progressFill = UIView(frame: progressFillFrame)
        progressFill.backgroundColor = UIColor(red: 1.0, green: 0.655, blue: 0.298, alpha: 1.0)
        
        progressBar.addSubview(progressFill)
        
    }
    
    
    
    
    
}
