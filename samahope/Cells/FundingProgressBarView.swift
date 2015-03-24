//
//  FundingProgressBarView.swift
//  samahope
//
//  Created by Ryan Newton on 3/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class FundingProgressBarView: UIView {
    func fillWithPercent(fillPerc: CGFloat) {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        self.backgroundColor = UIColor(red: 0.949, green: 0.941, blue: 0.929, alpha:1.0)
        let progressFillWidth = self.frame.width * fillPerc
        var progressFillFrame = CGRect(x: 0, y: 0, width: progressFillWidth, height: self.frame.height)
        let progressFill = UIView(frame: progressFillFrame)
        progressFill.backgroundColor = UIColor(red: 1.0, green: 0.655, blue: 0.298, alpha: 1.0)
        self.addSubview(progressFill)

    }
}
