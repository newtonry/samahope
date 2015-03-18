//
//  DummyDoctor.swift
//  samahope
//
//  Created by Isaac Ho on 3/14/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Doctor {
    var name: String?
    var location: String?
    var treatment: Treatment?
    var thumbnailPicUrl: String?
    var bannerPicUrl: String?
    var amountFunded: Int?
    var amountNeeded: Int?

/*
    @NSManaged var doctorName: String?
    @NSManaged var doctorImage: String?
    @NSManaged var doctorBanner: String?
    @NSManaged var doctorQuote: String?
    @NSManaged var doctorBio: String?
    @NSManaged var treatmentName: String?
    @NSManaged var treatmentImage: String?
    @NSManaged var treatmentDescription: String?
    @NSManaged var stories: String?
    @NSManaged var location: String?
    @NSManaged var amountNeeded: NSString?
    @NSManaged var totalAmount: NSString?
*/
    init( p: Project ) {
        self.name = p.doctorName
        self.location = p.location
        self.thumbnailPicUrl = p.doctorImage
        self.bannerPicUrl = p.doctorBanner
        self.amountFunded = 555 //XXX
        self.amountNeeded = 999 //( p.amountNeeded as String ).toInt() - model out of date
        
        
        var t = Treatment()
        t.description = p.treatmentDescription
        t.cost = 999   // XXX - need to add
        t.amountNeeded = 999 //(p.amountNeeded as String).toInt()
        t.amountFunded = 555 // XXX - need to add
        t.iconPicUrl = p.treatmentImage
        t.name = p.treatmentName
        
        self.treatment = t
    }
    init() {
        name = "Dr. Heebie Jeebies"
        location = "Baton Rouge"
        treatment = Treatment()
        treatment!.name = "Gout"
        amountFunded = 823
        amountNeeded = 1500
    }
    
}