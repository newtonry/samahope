//
//  Project.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Project : PFObject, PFSubclassing {

    @NSManaged var doctorName: String?
    @NSManaged var doctorImage: String?
    @NSManaged var doctorBanner: String?
    @NSManaged var doctorQuote: String?
    @NSManaged var doctorTopic: String?
    @NSManaged var doctorBio: String?
    @NSManaged var treatmentName: String?
    @NSManaged var treatmentImage: String?
    @NSManaged var treatmentDescription: String?
    @NSManaged var stories: String?
    @NSManaged var location: String?
//    @NSManaged var amountNeeded: NSString?
//    @NSManaged var totalAmount: NSString?
    @NSManaged var speakTime: NSDate?
    @NSManaged var amountNeeded: NSNumber?
    @NSManaged var totalAmount: NSNumber?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Project"
    }    
}