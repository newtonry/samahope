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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        tableView.allowsSelection = false;
        tableView.alwaysBounceVertical = false;
        
        setupGestureRecognizer()
        
    }

    func setupGestureRecognizer() {
        let recognizer = UIPanGestureRecognizer(target: self, action: "beingPulled:")
        recognizer.delegate = self
        self.tableView.addGestureRecognizer(recognizer)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // This is here so that the gesture recognizer doesn't block the table view scrolling
        return true
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
            // If the user is pulling up and there is no more space
            if (scrollView.contentOffset.y < 0) {
                scrollView.contentOffset = CGPointZero;
                self.scrollingAtTop = true
            }
        }
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollingAtTop = false
        println("Ended scrolling")
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
            NSLog("An unimportant state")
        }
    }
    
    @IBAction func onDonate(sender: AnyObject) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Isaac", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("DonateViewController") as DonateViewController
        vc.project = project
        self.showViewController(vc, sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
