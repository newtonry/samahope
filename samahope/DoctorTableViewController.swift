//
//  DoctorTableViewController.swift
//  samahope
//
//  Created by Isaac Ho on 3/14/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class DoctorTableViewController: UITableViewController {
    var events = ParseClient.sharedInstance.events
    var doctors: [Doctor]? // internally we use Doctors converted from Projects
    
    func onRefresh() {
        ParseClient.sharedInstance.loadEvents() {
            success in
            // events have been refreshed
            self.view.setNeedsDisplay()
            self.refreshControl!.endRefreshing()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        doctors = [Doctor]()
        var projects = ParseClient.sharedInstance.projects
        for ( var j = 0; j < projects!.count; j++ ) {
            var d = Doctor( p:projects![j])
            doctors!.append( d )
        }
        
        refreshControl = UIRefreshControl()
        self.view.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action:Selector("onRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        return doctors!.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyboard: UIStoryboard = UIStoryboard(name: "DoctorDetailView", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("DoctorDetailViewController") as DoctorDetailViewController
        vc.setProject( ParseClient.sharedInstance.projects![ indexPath.row ] )
        self.showViewController(vc, sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.doctortableviewcell", forIndexPath: indexPath) as DoctorTableViewCell

        cell.doctorMainImageView.alpha = 0
        
        // Configure the cell...
        cell.setDoctor( doctors![ indexPath.row ] )
        cell.setNeedsDisplay()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        /*var destVc = segue.destinationViewController as DonateViewController
        var event = events![0]
        destVc.project = event.projects[0] // XXX I'm just hard-coding the first one, but you should send in the one you want!
        */
    }
    

}
