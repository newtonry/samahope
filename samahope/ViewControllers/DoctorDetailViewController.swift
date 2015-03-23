//
//  DoctorDetailViewController.swift
//  samahope
//
//  Created by Ryan Newton on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    var project: Project?
    
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var scrollingAtTop: Bool = false
    private var scrollingPoint: CGPoint?
    private var doctorDescriptionCell: DoctorDetailInfoCell?
    private var expandedCells: [Int:Bool] = [:]
    
    private var expandableCells = [2, 3, 4] // this is a pretty silly way, but works for now.
    let BASE_CELLS_COUNT = 4 // doctordetailinfocell, funding cell, moredoctordetailcell, treatment
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        tableView.alwaysBounceVertical = false;
        setupGestureRecognizer()
    }
    
    @IBAction func onBackButtonPress(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("DoctorDetailInfoCell") as DoctorDetailInfoCell
            cell.fillWithProject(project!)
            self.doctorDescriptionCell = cell
            return cell
        case 1:
            let cellNib = UINib(nibName: "FundingStatusCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "FundingStatusCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("FundingStatusCell") as FundingStatusCell

            cell.setWithProject(project!)
            return cell
        case 2:
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("About \(project!.doctorName!)", imageUrlString: project!.doctorImage!, secondHeader: "Over 15,000 babies delivered", textBody: project!.doctorBio!)
            return cell
        case 3:
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("About the treatment", imageUrlString: project!.treatmentImage!, secondHeader: project!.treatmentName!, textBody: project!.treatmentDescription!)
            return cell
        case 4: // I guess there's no >= in case statements
            let cellNib = UINib(nibName: "MoreDoctorDetailCell", bundle: nil)
            tableView.registerNib(cellNib, forCellReuseIdentifier: "MoreDoctorDetailCell")
            let story = project!.storiesToObjects()[0] // just showing 1 story for now
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreDoctorDetailCell") as MoreDoctorDetailCell
            cell.fillWithDescriptionAndImage("Patient Stories", imageUrlString: story.image, secondHeader: story.patients, textBody: story.content)
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
            if let hasKey = expandedCells[indexPath.row] {
                return UITableViewAutomaticDimension
            }
            return 150
        case 3:
            if let hasKey = expandedCells[indexPath.row] {
                return UITableViewAutomaticDimension
            }
            return 150
        case 4:
            if let hasKey = expandedCells[indexPath.row] {
                return UITableViewAutomaticDimension
            }
            return 150
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if contains(expandableCells, indexPath.row) {
            expandedCells[indexPath.row] = true
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
    func setProject(project: Project) {
        self.project = project
    }
    
    @IBAction func onDonate(sender: AnyObject) {
        
        self.project!.storiesToObjects()
        
        
        
        var storyboard: UIStoryboard = UIStoryboard(name: "Isaac", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("DonateViewController") as DonateViewController
        vc.project = project
        self.showViewController(vc, sender: self)

    }
    
    /////////////////////////////
    //Image zoom
    /////////////////////////////
    func setupGestureRecognizer() {
        let recognizer = UIPanGestureRecognizer(target: self, action: "beingPulled:")
        recognizer.delegate = self
        self.tableView.addGestureRecognizer(recognizer)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // This is here so that the gesture recognizer doesn't block the table view scrolling
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == tableView) {
            // If the user is pulling up and there is no more space
            if (scrollView.contentOffset.y < 0) {
                scrollView.contentOffset = CGPointZero;
                self.scrollingAtTop = true
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollingAtTop = false
        if let ddc = self.doctorDescriptionCell {
            ddc.animateBannerBackToNormal()
        }
    }
    
    func beingPulled(sender: UIPanGestureRecognizer) {
        // don't want to do anything unless we're at the top
        if !scrollingAtTop {
            return
        }
        switch (sender.state){
        case .Changed:
            let location = sender.locationInView(self.view)
            if let point = scrollingPoint {
                let pointDifference = location.y - scrollingPoint!.y
                if pointDifference > 0 {
                    let newRatio = (100.0 + pointDifference * 0.5)/100
                    if let ddc = self.doctorDescriptionCell {
                        ddc.increaseBannerSizeByRatio(newRatio)
                    }
                }
            } else {
                scrollingPoint = location
            }
        case .Ended, .Cancelled:
            scrollingPoint = nil
            if let ddc = self.doctorDescriptionCell {
                ddc.animateBannerBackToNormal()
            }
        default:
            return
        }
    }
}
