//
//  CircleTitleView.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class CircleTitleView: UIView {

    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setWithImageStringAndTitle(imageString: String, title: String) {
        // When it's a remote image
        let imageUrl = NSURL(string: imageString)
        self.circleImage.setImageWithURL(imageUrl!)
        self.title.text = title
    }

    func setWithImageAndTitle(image: UIImage, title: String) {
        // When it's a local image
        self.circleImage.image = image
        self.title.text = title
    }
}
