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
    @NSManaged var speakTime: NSDate?
    @NSManaged var amountNeeded: NSNumber?
    @NSManaged var totalAmount: NSNumber?
    private var actualBannerImage: UIImage?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }

    func loadBannerIntoImageViewAsnync(callback: (UIImage)->Void) {
        let imageView = UIImageView()
        
        
        if let img = actualBannerImage as UIImage! {
            callback(img)
        } else {
            let imageUrl = NSURL(string: doctorBanner!)

            
            imageView.setImageWithURL(imageUrl)
            
            
            let urlRequest = NSURLRequest(URL: imageUrl!)
            imageView.setImageWithURLRequest(urlRequest, placeholderImage: nil, success: {(request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                self.actualBannerImage = image // Project.cropBannerImage(image)
                callback(image)
                }, failure: nil)
        }
    }
    
    
    class func cropBannerImage(image: UIImage) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.1, 0.1))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    
    
    
    
    
    class func parseClassName() -> String! {
        return "Project"
    }    
}