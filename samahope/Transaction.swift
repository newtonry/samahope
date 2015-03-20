//
//  Transaction.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Transaction : PFObject, PFSubclassing {
    @NSManaged var amount : String? // in dollars
    @NSManaged var timeStamp: String?
    @NSManaged var project: Project?
    @NSManaged var event: Event?
    
    func setValues( amount_:Int, project project_:Project, event event_:Event) {
        amount = String(amount_)
        project = project_
        event = event_
        timeStamp =  NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)

    }
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Transaction"
    }

}