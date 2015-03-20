//
//  ProgramViewController.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/17/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProgramButtonsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDonationTotal: UILabel!
    
    var rootEvent: Event?
    var projects: [Project]?
    var startTime: NSDate?
    
    let events = ParseClient.sharedInstance.events
    let programCellId = "ProgramTableViewCell"
    let formatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 215
        
        
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.maximumFractionDigits = 0
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        
        if let e = events {
            if let event = e[0] as Event? {
                self.rootEvent = event
                self.startTime = rootEvent!.startTime
                self.projects = rootEvent!.projects
                self.eventName.text = rootEvent!.name as String!
                self.eventDescription.text = rootEvent!.eventDescription
                self.eventDonationTotal.text = formatter.stringFromNumber(rootEvent!.totalDonations!)
            }
        }
        let cellNib = UINib(nibName: "ProgramTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "ProgramTableViewCell")
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(programCellId, forIndexPath: indexPath) as ProgramTableViewCell

        if let p = projects {
            if let project = p[indexPath.row] as Project? {
                cell.delegate = self
                cell.project = project
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func onDonateButtonCellPress(cell: ProgramTableViewCell) {
        let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
        let projectVC = storyboard.instantiateInitialViewController() as? UINavigationController
        self.presentViewController(projectVC!, animated: true, completion: nil)
    }
    
    func onLearnButtonCellPress(cell: ProgramTableViewCell) {
        let storyboard = UIStoryboard(name: "DoctorDetailView", bundle: nil)
        let projectViewController = storyboard.instantiateInitialViewController() as? DoctorDetailViewController
        projectViewController!.setProject(cell.project!)
        self.presentViewController(projectViewController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
