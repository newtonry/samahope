//
//  ViewController.swift
//  SamaHope
//
//  Created by Jeremy Hageman on 3/8/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var projectsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectsTableView.dataSource = self
        
        let cellNib = UINib(nibName: "ProjectTableViewCell", bundle: NSBundle.mainBundle())
        projectsTableView.registerNib(cellNib, forCellReuseIdentifier: "ProjectTableViewCell")
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProjectTableViewCell", forIndexPath: indexPath) as ProjectTableViewCell

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

