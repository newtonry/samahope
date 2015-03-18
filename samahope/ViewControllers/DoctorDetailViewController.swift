//
//  DoctorDetailViewController.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorDetailViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    private var project: Project?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        tableView.allowsSelection = false;
        tableView.alwaysBounceVertical = false;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("DoctorDetailInfoCell") as DoctorDetailInfoCell
            cell.fillWithProject(project!)
            return cell
        case 1:
            let cellNib = UINib(nibName: "FundingStatusCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "FundingStatusCell")

            let cell = tableView.dequeueReusableCellWithIdentifier("FundingStatusCell") as FundingStatusCell
            cell.setWithStats(10, treatmentsGoal: 50, amountRaised: 450, amountPerProcedure: 1100)
            return cell

        case 2:
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("About \(project!.doctorName!)", imageUrlString: project!.doctorImage!)            
            return cell
        case 3:
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("About the treatment", imageUrlString: project!.treatmentImage!)
            return cell
        case 4:
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("Patient Stories", imageUrlString: project!.treatmentImage!)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("DoctorDetailInfoCell") as DoctorDetailInfoCell
            cell.fillWithProject(project!)
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // this is pretty dumb to set it this way for now
        
        switch indexPath.row {
        case 0:
            return 315
        case 1:
            return 135
        case 2:
            return 65
        case 3:
            return 65
        case 4:
            return 65

        default:
            return 0
        }
    }
    
    func setProject(project: Project) {
        self.project = project
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == tableView) {
            if (scrollView.contentOffset.y < 0) {
                scrollView.contentOffset = CGPointZero;
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        println("Ended scrolling")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
