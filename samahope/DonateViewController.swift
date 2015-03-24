//
//  DonateViewController.swift
//  samahope
//
//  Created by Isaac Ho on 3/15/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit
import PassKit

class DonateViewController: UIViewController, UITextFieldDelegate {
    var project: Project? // XXX previous controller must set this first!
    
    var selectedAmount: Int?
    var bProcessingPayment = false

    @IBOutlet weak var fullAmountLabel: UILabel!
    @IBOutlet weak var completeAmountLabel: UILabel!
    @IBOutlet weak var halfAmountLabel: UILabel!
    @IBOutlet weak var customTextField: UITextField!
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var completeView: UIView!
    
    @IBOutlet weak var halfView: UIView!
    
    @IBOutlet weak var fullView: UIView!
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePaySwagMerchantID = "merchant.com.codepath.SamaHope" // Fill in your merchant ID here!
    
    var highlightColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)

    @IBAction func onHalfTap(sender: AnyObject) {
        selectedAmount = halfAmountLabel!.text!.toInt()
        unHighlightAll()
        halfView.backgroundColor = highlightColor
        customTextField.resignFirstResponder()

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true){}
    }
    @IBAction func onFullTap(sender: AnyObject) {
        selectedAmount = fullAmountLabel!.text!.toInt()
        unHighlightAll()
        fullView.backgroundColor = highlightColor
        customTextField.resignFirstResponder()

    }
    @IBAction func onCompleteTap(sender: AnyObject) {
        selectedAmount = completeAmountLabel!.text!.toInt()
        unHighlightAll()
        completeView.backgroundColor = highlightColor
        customTextField.resignFirstResponder()

    }
    func unHighlightAll()
    {
        var c = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        customView.backgroundColor = c
        completeView.backgroundColor = c
        halfView.backgroundColor = c
        fullView.backgroundColor = c
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        var textField = sender as UITextField
        
        selectedAmount = textField.text.toInt()
    }
    @IBAction func onTap(sender: AnyObject) {
        customTextField.resignFirstResponder()
      
    }
    
    @IBAction func onCustomEditStart(sender: AnyObject) {
        customTextField.text = ""
        unHighlightAll()
        customView.backgroundColor = highlightColor
    }
    @IBAction func onPay(sender: AnyObject) {
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: project!.doctorName!, amount: NSDecimalNumber(integer:selectedAmount!)),
            PKPaymentSummaryItem(label: "samaHope", amount: NSDecimalNumber(integer:selectedAmount!) )
            
        ]
        
        let applePayController = STPTestPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self

    
        /*self.addChildViewController(applePayController)
        applePayController.view.bounds = CGRect(x:0,y:-100,width:300,height:300)
        self.view.addSubview(applePayController.view)
        applePayController.didMoveToParentViewController(self)
        */
        
        self.presentViewController(applePayController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedAmount = Int(0)
        halfAmountLabel.text = String( Int( project!.totalAmount! ) / 2 )
        fullAmountLabel.text = String( Int( project!.totalAmount! ))
        completeAmountLabel.text = String( Int( project!.amountNeeded! ))
        
        // Do any additional setup after loading the view.
        println( "DonateVC: viewDidLoad")
        customTextField.keyboardType = UIKeyboardType.NumberPad
        customTextField.returnKeyType = UIReturnKeyType.Done
        customTextField.delegate = self
        unHighlightAll()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DonateViewController: PKPaymentAuthorizationViewControllerDelegate {
    // huge hack!  should refactor with appDelegate which builds and shows the same VC
    func goToMainVC() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.presentViewController(appDelegate.mvc!, animated:true, completion:nil)
    }
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        
        bProcessingPayment = true
        println( "payment auth complete: saving objects to db" )
        ParseClient.sharedInstance.processPayment( selectedAmount!, project: project!, event: ParseClient.sharedInstance.events![0])

        var confirmMessage = "$\(selectedAmount!) to \(project!.doctorName!) has been processed.  Thank you!"
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Payment confirmed", message: confirmMessage, preferredStyle: .ActionSheet)
        var action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            println( "dismissing self")
            
            self.performSegueWithIdentifier("goHome", sender: self)
        }
        actionSheetController.addAction( action )
        
        controller.presentViewController(actionSheetController, animated: true, completion: nil)

        
        completion(PKPaymentAuthorizationStatus.Success)

    }
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        // popup confirmation screen?
        if ( !bProcessingPayment ) { controller.dismissViewControllerAnimated(true, completion: nil ) }
        bProcessingPayment = false
    }
}

