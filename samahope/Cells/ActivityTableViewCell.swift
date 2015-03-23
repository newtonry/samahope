//
//  ActivityTableViewCell.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    var alertMutableString = NSMutableAttributedString()
    let dateFormatter = NSDateFormatter()
    let moneyFormatter = NSNumberFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateFormatter.dateFormat = "MMM dd, yyyy, hh:mm a"
        moneyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        moneyFormatter.maximumFractionDigits = 0
        moneyFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
        self.activityLabel.preferredMaxLayoutWidth = self.activityLabel.frame.size.width
    }
    
    var transaction: Transaction? {
        didSet {
            setActivityData()
        }
    }
    
    func setActivityData() {
        if let t = transaction {
            if let p = t.project {
                let donationAmount = t.amount!.toInt()
                let formattedAmount = moneyFormatter.stringFromNumber(donationAmount!)
                var activityStr:NSString = "\(p.doctorName!) received a \(formattedAmount!) donation."
                let activityLength = activityStr.length
                let timeString = self.dateFormatter.dateFromString(t.timeStamp!)
                let timeAgo = ActivityTableViewCell.timeAgoSinceDate(timeString!, numericDates: true)
                let timeLength = countElements(timeAgo)
                activityStr = activityStr + " " + timeAgo
                alertMutableString = NSMutableAttributedString(string: activityStr, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Medium", size: 11.0)!])
                alertMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: NSRange(location:activityLength+1,length: timeLength))
                self.activityLabel.attributedText = alertMutableString
                self.activityLabel.preferredMaxLayoutWidth = self.activityLabel.frame.size.width
                self.profileImage.setImageWithURL(NSURL(string: p.doctorImage!))
                self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
                self.profileImage.clipsToBounds = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.activityLabel.preferredMaxLayoutWidth = self.activityLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //  "Time ago" function for Swift (based on MatthewYork's DateTools for Objective-C)
    //  https://gist.github.com/minorbug/468790060810e0d29545
    class func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags = NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitSecond
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
        
        if (components.year >= 1) {
            return "\(components.year)y"
        } else if (components.month >= 1) {
            return "\(components.month)m"
        } else if (components.weekOfYear >= 1) {
            return "\(components.weekOfYear)w"
        } else if (components.day >= 1) {
            return "\(components.day)d"
        } else if (components.hour >= 1) {
            return "\(components.hour)h"
        } else if (components.minute >= 1) {
            return "\(components.minute)m"
        } else {
            return "\(components.second)s"
        }
    }
}
