//
//  ViewController.swift
//  SamaHope
//
//  Created by Jeremy Hageman on 3/8/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var rootEvent: Event?
    var projects: [Project]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        ParseClient.loadEventWithCallback({(event: Event?)-> Void in
            self.rootEvent = event!
            self.projects = self.rootEvent?.projects
            self.tableView.reloadData()
        })

        let cellNib = UINib(nibName: "ProjectTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: "ProjectTableViewCell")
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProjectTableViewCell", forIndexPath: indexPath) as ProjectTableViewCell

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = projects {
            return arr.count
        }
        return 0
    }
    
    func tableView(projectsTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let project = projects![indexPath.row]
        
        
        println(project)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func toNextVC(sender: UITapGestureRecognizer) {
//        // This is only for the animated gif, should not be here later
//        let storyboard = UIStoryboard(name: "ProjectStoryboard", bundle: nil)
//        let projectVC = storyboard.instantiateInitialViewController() as? ProjectViewController
//        
//        self.presentViewController(projectVC!, animated: true, completion: nil)
//    }
}

