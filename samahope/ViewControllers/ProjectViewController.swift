//
//  ProjectViewController.swift
//  samahope
//
//  Created by Ryan Newton on 3/9/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!

    @IBOutlet weak var leftCircleTitleView: CircleTitleView!
    @IBOutlet weak var rightCircleTitleView: CircleTitleView!
    
    @IBOutlet weak var fundingStatusView: FundingStatusView!
    @IBOutlet weak var doctorDetailsTableView: UITableView!
    
    
    private var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        leftCircleTitleView.l
        
        scrollView.contentSize = contentView.frame.size
        
        
        if (project != nil) {
            fillElements()
        }
    }

    func fillElements() {
        let bannerUrl = NSURL(string: project!.doctorBanner!)
        bannerImage.setImageWithURL(bannerUrl!)
        doctorName.text = project!.doctorName!
        
        leftCircleTitleView.setWithImageAndTitle(UIImage(named: "map-marker")!, title: project!.location!)
        rightCircleTitleView.setWithImageStringAndTitle(project!.treatmentImage!, title: project!.treatmentName!)
        fundingStatusView.setWithStats(10, treatmentsGoal: 50, amountRaised: 450, amountPerProcedure: 1100)

        
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func donateNowPressed(sender: UIButton) {
//        let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
//        let projectVC = storyboard.instantiateInitialViewController() as? UINavigationController
//        self.presentViewController(projectVC!, animated: true, completion: nil)
//    }
    
    func setProject(project: Project) {
        self.project = project
    }
}
