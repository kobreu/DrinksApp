//
//  ViewControllers.swift
//  SwiftTest
//
//  Created by Korbinian Breu on 22/01/15.
//  Copyright (c) 2015 Korbinian Breu. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class CustomTableViewCell : UITableViewCell {
    @IBOutlet weak var button: UIButton!
}

class Employee {
    var name = "fribbu"
    var amount = 0
    
    init(name:String, amount: Int){
        self.name = name
        self.amount = amount
    }
    
}

class DataManager {
    
    func employeeList(success: (Array<Employee>) -> Void, failure: () -> Void)  {
        success([Employee(name: "Pedro", amount: 0), Employee(name: "Sanda", amount: 0), Employee(name: "David", amount: 0), Employee(name: "Per", amount: 0), Employee(name: "Michael", amount: 0), Employee(name: "Dmitry", amount: 0), Employee(name: "David", amount: 0), Employee(name: "Ahmed", amount: 0), Employee(name: "Abhi", amount: 0), Employee(name: "Simon 1.3", amount: 0), Employee(name: "Simon 2.0", amount: 0), Employee(name: "Thorsten", amount: 0), Employee(name: "Sanda", amount: 0)]);
    }
}


class EmployeeTableController : UITableViewController {
    
    var employees = []
    
    var datamanager = DataManager()
    
    override func viewDidLoad() {
        datamanager.employeeList({ (employees) -> Void in
            self.employees = employees
            self.tableView.reloadData()
        }, failure: { () -> Void in
            
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "identifier";
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as CustomTableViewCell;
        let index = indexPath.row
        cell.textLabel?.text = toString(index)
       // cell.textLabel?.text = self.employees[index].name
        //cell.detailTextLabel?.text = toString(self.employees[index].amount)
        let button = UIButton();
        button.setTitle("title", forState: .Normal);
        [cell.addSubview(button)];
        return cell
    }
    
    
    @IBAction func pay(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("pay") as UIViewController
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet;
        self.presentViewController(controller, animated: true) { () -> Void in
            
        };
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(DrinksTableController(), animated: true);
    }
}

class DrinksTableController : UITableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "identifier";
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as UITableViewCell;
        cell.textLabel?.text = "drink"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.popViewControllerAnimated(true);
       /* var alert = UIAlertController(title: "Yay", message: "5€, wanna pay now?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Pay later...", style: UIAlertActionStyle.Cancel, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Pay now!", style: UIAlertActionStyle.Default, handler: nil))

        self.presentViewController(alert, animated: true, completion: nil)*/
    }
}

class PayController : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!

    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var receipt: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var paymentProcess:MPPaymentProcess!
    var actualReceipt: MPReceipt!
    
    override func viewDidAppear(animated: Bool) {
        let transactionProvider = MPMpos.transactionProviderForMode(MPProviderMode.TEST, merchantIdentifier: "f41e0335-dd3a-4849-a129-29b44bdd21a2", merchantSecretKey: "iqL6Vq8C4jnK7Wq9BDFUiZEGfHJNoABY")
        
        let amt = "108.20"
        
        let transactionTemplate = transactionProvider.chargeTransactionTemplateWithAmount(NSDecimalNumber(string: amt), currency: MPCurrency.EUR, subject: "subject", customIdentifier: "customIdentifier")
        
        self.paymentProcess = transactionProvider.startPaymentWithTemplate(transactionTemplate, usingAccessory: MPAccessoryFamily.MiuraMPI, registered: { (process:MPPaymentProcess!, transaction:MPTransaction!) -> Void in
            // do sth
            }, statusChanged: { (process:MPPaymentProcess!, transaction:MPTransaction?, processDetails:MPPaymentProcessDetails!) -> Void in
                // do sth
                self.line1.text = processDetails.information[0] as String
                self.line2.text = processDetails.information[1] as String
                self.cancel.hidden = !(transaction?.canBeAborted() ?? false)

            }, actionRequired: { (process:MPPaymentProcess!, transaction:MPTransaction!, transactionAction:MPTransactionAction, transactionActionSupport:MPTransactionActionSupport?) -> Void in
                switch (transactionAction) {
                case MPTransactionAction.CustomerSignature:
                    // In a live app, this image comes from your signature screen
                    let signatureViewController = MPBSignatureViewController()
                    signatureViewController.merchantName = "Getränke"
                    signatureViewController.amountText = amt + " €"
                    signatureViewController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
                    self.presentViewController(signatureViewController, animated: true, completion: nil)
                    signatureViewController.registerOnPay({ () -> Void in
                        self.paymentProcess.continueWithCustomerSignature(signatureViewController.signature(), verified: true)
                    }, onCancel: { () -> Void in
                        self.paymentProcess.continueWithCustomerSignature(nil, verified: false)
                    })
                case MPTransactionAction.CustomerIdentification:
                    self.paymentProcess.continueWithCustomerIdentityVerified(false)
                default:
                    println("default")
                }
            }, ended: { (process:MPPaymentProcess!, transaction:MPTransaction?, paymentProcessDetails:MPPaymentProcessDetails!) -> Void in
                self.cancel.hidden = true
                self.done.hidden = false;
                if(transaction?.status == MPTransactionStatus.Approved) {
                    self.receipt.hidden = false
                    self.actualReceipt = process.receiptFactory.customerReceiptForTransaction(transaction)
                }
            })
    }
    
    @IBAction func sned(sender: AnyObject) {
        let controller = MFMailComposeViewController()
        controller.setSubject("payworks Receipt")
        controller.setCcRecipients(["sanda.bozic@payworksmobile.com"])
        controller.setMessageBody(self.actualReceipt.prettyPrinted(), isHTML: false)
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        controller.mailComposeDelegate = self
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        // do nothing?
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func doen(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func abrot(sender: AnyObject) {
        self.paymentProcess.requestAbort()
    }
}
