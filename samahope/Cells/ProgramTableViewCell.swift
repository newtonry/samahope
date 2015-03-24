//
//  ProgramTableViewCell.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/16/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

protocol ProgramButtonsCellDelegate: class {
    func onDonateButtonCellPress(cell: ProgramTableViewCell)
    func onLearnButtonCellPress(cell: ProgramTableViewCell)
}

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var donationStatusLabel: UILabel!
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var learnButton: UIButton!
    
    weak var delegate: ProgramButtonsCellDelegate?
    
    var formatter = NSDateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.formatter.timeStyle = .ShortStyle
        self.topicLabel.preferredMaxLayoutWidth = self.topicLabel.frame.size.width
        self.donateButton.layer.cornerRadius = 2
        self.learnButton.layer.cornerRadius = 2
        self.learnButton.layer.borderWidth = 1.0
        let borderColor = UIColor(red: CGFloat(151/255.0), green: CGFloat(151/255.0), blue: CGFloat(151/255.0), alpha: 1)
        self.learnButton.layer.borderColor = borderColor.CGColor
    }
    
    var project: Project? {
        didSet {
            setProgramData()
        }
    }
    
    func setProgramData() {
        if let p = project {
            self.timeLabel.text = formatter.stringFromDate(p.speakTime!)
            self.topicLabel.text = p.doctorTopic
            self.speakerLabel.text = "Speaker: \(p.doctorName!)"
            
            let total = p.totalAmount!.integerValue
            let needed = p.amountNeeded!.integerValue
            let amountRaised = total - needed
            self.donationStatusLabel.text = "$\(amountRaised) raised of $\(p.totalAmount!)"
        
            let percComplete = CGFloat(amountRaised) / CGFloat(total)
            let progressFillWidth = statusBarView.frame.width * percComplete
        
            var progressFillFrame = CGRect(x: 0, y: 0, width: progressFillWidth, height: statusBarView.frame.height)
            let progressFill = UIView(frame: progressFillFrame)
            progressFill.backgroundColor = UIColor(red: 1.0, green: 0.655, blue: 0.298, alpha: 1.0)
        
            statusBarView.addSubview(progressFill)
        }
    }

    @IBAction func onDonate(sender: UIButton) {
        self.delegate?.onDonateButtonCellPress(self)
    }
    
    @IBAction func onLearn(sender: UIButton) {
        self.delegate?.onLearnButtonCellPress(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.topicLabel.preferredMaxLayoutWidth = self.topicLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
