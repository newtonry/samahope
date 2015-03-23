//
//  FundingStatusCell.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class FundingStatusCell: UITableViewCell {

    
    
    @IBOutlet weak var progressBar: FundingProgressBarView!
    @IBOutlet weak var amountRaisedLabel: UILabel!
    @IBOutlet weak var treatmentStats: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.backgroundColor = UIColor(red: 0.976, green: 0.973, blue: 0.969, alpha: 1.0)
        self.progressBar.backgroundColor = UIColor(red: 0.949, green: 0.941, blue: 0.929, alpha:1.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setWithProject(project: Project) {
        let treatmentsFulfilled = 10
        let treatmentsGoal = 50
        let amountRaised = project.amountNeeded!
        let amountPerProcedure = project.totalAmount!
        
        treatmentStats.text = "Treatment \(treatmentsFulfilled) of \(treatmentsGoal) needed"
        amountRaisedLabel.text = "$\(amountRaised) raised of $\(amountPerProcedure)"
        let percComplete = CGFloat(amountRaised) / CGFloat(amountPerProcedure)
        progressBar.fillWithPercent(percComplete)
    }
}
