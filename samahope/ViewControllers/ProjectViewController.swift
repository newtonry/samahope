//
//  ProjectViewController.swift
//  samahope
//
//  Created by Ryan Newton on 3/9/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var procedureView: UIImageView!
    @IBOutlet weak var docProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.docProfileImage.layer.cornerRadius = self.docProfileImage.frame.size.width / 2
        self.docProfileImage.clipsToBounds = true
        self.docProfileImage.layer.borderWidth = 2.0
        self.docProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donateNowPressed(sender: UIButton) {
        let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
        let projectVC = storyboard.instantiateInitialViewController() as? UINavigationController
        self.presentViewController(projectVC!, animated: true, completion: nil)
    }
}
