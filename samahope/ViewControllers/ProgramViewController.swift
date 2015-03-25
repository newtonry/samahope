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
    var EVENTS_POLLING_INTERVAL = 2.0

    var events : [Event]?
    let programCellId = "ProgramTableViewCell"
    let formatter = NSNumberFormatter()
    
    func updateEvents() {
        println( "update events" )
        ParseClient.sharedInstance.loadEventsInForeground()
            println( "done loading events")
            self.events = ParseClient.sharedInstance.events
        
            if let e = self.events {
                if let event = e[0] as Event? {
                    self.rootEvent = event
                    self.startTime = self.rootEvent!.startTime
                    self.projects = self.rootEvent!.projects
                    self.eventName.text = self.rootEvent!.name as String!
                    self.eventDescription.text = self.rootEvent!.eventDescription
                    self.eventDonationTotal.text = "$\(self.rootEvent!.totalDonations!.integerValue)"
                }
            }
        
            self.view.setNeedsDisplay()
            self.tableView.reloadData()
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 215
        
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.maximumFractionDigits = 0
        formatter.locale = NSLocale(localeIdentifier: "en_US")

        updateEvents()

        let cellNib = UINib(nibName: programCellId, bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: programCellId)
        var timer = NSTimer.scheduledTimerWithTimeInterval(self.EVENTS_POLLING_INTERVAL, target: self, selector: Selector("updateEvents"), userInfo: nil, repeats: true)

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
        if let e = rootEvent {
            return rootEvent!.projects.count
        }
        return 0
    }
    
    func onDonateButtonCellPress(cell: ProgramTableViewCell) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Isaac", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("DonateViewController") as DonateViewController
        vc.project = cell.project!
        self.showViewController(vc, sender: self)
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
