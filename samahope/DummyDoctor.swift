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

    init( p: Project ) {
        self.name = p.doctorName
        self.location = p.location
        self.thumbnailPicUrl = p.doctorImage
        self.bannerPicUrl = p.doctorBanner
        self.amountFunded = p.totalAmount!.integerValue - p.amountNeeded!.integerValue
        self.amountNeeded = p.amountNeeded!.integerValue
        
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