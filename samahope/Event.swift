//
//  Event.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Event : PFObject, PFSubclassing {
    @NSManaged var name: String?
    @NSManaged var location: String?
    @NSManaged var projects : [Project]
    @NSManaged var date : String?
    
    // live event components
    @NSManaged var currentSpeaker: Project?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    override init() {
        super.init()
    }
    class func parseClassName() -> String! {
        return "Event"
    }
}