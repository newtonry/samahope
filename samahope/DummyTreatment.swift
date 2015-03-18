//
//  DummyTreatment.swift
//  samahope
//
//  Created by Isaac Ho on 3/14/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Treatment {
    var name: String?
    var iconPicUrl: String?
    var description: String?
    var amountFunded: Int?
    var cost: Int?
    var amountNeeded: Int?

    
    init() {
       name = "general malaise"
        iconPicUrl = ""
        description = "Malaise is a real problem in underdeveloped countries.  People sit around, playing with their iPads and eating cake."
        amountFunded = 1230
        amountNeeded = 5000
        cost = 100
    }
}