//
//  ActivityFeedViewController.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ActivityFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var transactions: [Transaction]?
    
    let activityCellId = "ActivityTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 50

        let cellNib = UINib(nibName: activityCellId, bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: activityCellId)
    }
    
    func loadTransactions() {
        ParseClient.sharedInstance.loadTransactions(20) { (newTransactions: [Transaction])
        in
            self.transactions = newTransactions
            println(">> loading \(self.transactions!.count) transactions")
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTransactions()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = transactions {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(activityCellId, forIndexPath: indexPath) as ActivityTableViewCell
        
        if let trans = transactions {
            if let t = trans[indexPath.row] as Transaction? {
                cell.transaction = t
            }
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
