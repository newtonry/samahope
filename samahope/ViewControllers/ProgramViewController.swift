//
//  ProgramViewController.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/17/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource, ProgramButtonsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDonationTotal: UILabel!
    
    var rootEvent: Event?
    var events: [Event]?
    var projects: [Project]?
    
    let programCellId = "ProgramTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 215
        
//        ParseClient.loadEventWithCallback({(event: Event?)-> Void in
//            self.rootEvent = event!
//            self.projects = self.rootEvent?.projects
//            self.tableView.reloadData()
//        })
        self.eventName.text = rootEvent?.name
        self.eventDescription.text = rootEvent?.eventDescription
        self.eventDonationTotal.text = "$\(rootEvent?.totalDonations)"
        let cellNib = UINib(nibName: "ProgramTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "ProgramTableViewCell")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(programCellId, forIndexPath: indexPath) as ProgramTableViewCell
        if let p = projects {
        if let project = p[indexPath.row] as Project? {
            cell.project = project
        }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func onDonateButtonCellPress(cell: ProgramTableViewCell) {
        println("Load payment view")
//        let storyboard = UIStoryboard(name: "PaymentStoryboard", bundle: nil)
        //        let projectVC = storyboard.instantiateInitialViewController() as? UINavigationController
        //        self.presentViewController(projectVC!, animated: true, completion: nil)
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
