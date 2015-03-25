//
//  ActivityFeedViewController.swift
//  samahope
//
//  Created by Jeremy Hageman on 3/20/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ActivityFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var eventDonationTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var transactions: [Transaction]?
    var rootEvent: Event?
    var events = ParseClient.sharedInstance.events
    let EVENTS_POLLING_INTERVAL = 5
    let activityCellId = "ActivityTableViewCell"
    
    var formatter = NSNumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 56

        let cellNib = UINib(nibName: activityCellId, bundle: NSBundle.mainBundle())
        tableView.registerNib(cellNib, forCellReuseIdentifier: activityCellId)
        
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.maximumFractionDigits = 0
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            while( true ) {
                sleep( UInt32(self.EVENTS_POLLING_INTERVAL) )
                self.events = ParseClient.sharedInstance.events
                self.loadTransactions()
            }
        }
    }
    
    func updateEventTotal() {
        var newFormatter = NSNumberFormatter()
        newFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        newFormatter.maximumFractionDigits = 0
        newFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
        
        self.eventDonationTotal.text = newFormatter.stringFromNumber(rootEvent!.totalDonations!)//"\(rootEvent!.totalDonations!)"
    }
    
    func loadTransactions() {
        if let e = events {
            if let event = e[0] as Event? {
                self.rootEvent = event
                self.eventDonationTotal.text = formatter.stringFromNumber(rootEvent!.totalDonations!)
            }
        }
        
        ParseClient.sharedInstance.loadTransactions(20) { (newTransactions: [Transaction])
        in
            self.transactions = newTransactions
//            println(">> loading \(self.transactions!.count) transactions")
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
        }
        self.updateEventTotal()
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