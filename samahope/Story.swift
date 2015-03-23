//
//  Story.swift
//  samahope
//
//  Created by Ryan Newton on 3/22/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class Story: NSObject {
    var patients: NSString
    var image: NSString
    var content: NSString
    
    init(patients: NSString, image: NSString, content: NSString) {
        self.patients = patients
        self.image = image
        self.content = content
    }
    
    convenience init(json: NSDictionary) {
        let patients = json["patients"] as NSString
        let image = json["image"] as NSString
        let content = json["story_content"] as NSString
        self.init(patients: patients, image: image, content: content)
    }
}
