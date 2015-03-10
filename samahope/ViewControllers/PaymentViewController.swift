//
//  PaymentViewController.swift
//  samahope
//
//  Created by Ryan Newton on 3/10/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let PAYMENT_OPTIONS = [
        ["CARD", "****-6789"],
        ["BILLING ADDRESS", "123 Fake St."],
        ["CONTACT", "Moe Szyslak"],
        ["TOTAL", "$154.00"]
    ]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let option = PAYMENT_OPTIONS[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PaymentTableViewCell") as PaymentTableViewCell
        cell.optionName.text = option[0]
        cell.optionValue.text = option[1]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PAYMENT_OPTIONS.count
    }
}
