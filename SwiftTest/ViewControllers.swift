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
import ObjectMapper
import AFNetworking

class CustomTableViewCell : UITableViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var amt: UILabel!
    @IBOutlet weak var pay: UIButton!
}

class Employee : NSObject, Mappable {
    var mid = 0
    var title = "fribbu"
    var amount = 0
    
    required override init() {}
    
    init(id:Int, name:String, amount: Int){
        self.mid = id
        self.title = name
        self.amount = amount
    }
    
    func map(mapper: Mapper) {
        self.mid <= mapper["id"]
        self.title <= mapper["name"]
        self.amount <= mapper["amount"]
    }
    
}

class Drink : NSObject, Mappable {
    var title = ""
    var cost = 100
    
    required override init() {}
    
    init(name:String, cost: Int) {
        self.title = name
        self.cost = cost
   }
    
    func map(mapper: Mapper) {
        self.title <= mapper["name"]
        self.cost <= mapper["cost"]
    }
}


class MerchantData : NSObject, Mappable {
    var name = "payworks GmbH"
    var street = "Grillparzerstraße 14"
    var townzip = "81675 München"
    var country = "Deutschland"
    var merchantIdentifier = "f41e0335-dd3a-4849-a129-29b44bdd21a2"
    var merchantSecretKey = "iqL6Vq8C4jnK7Wq9BDFUiZEGfHJNoABY"
    var serverType = "TEST"
    var readerModel = "MIURA"
    var paymentEnabled = true
    
    required override init() {}
    
    func map(mapper: Mapper) {
        self.name <= mapper["name"]
        self.street <= mapper["street"]
        self.townzip <= mapper["townzip"]
        self.country <= mapper["country"]
        self.merchantIdentifier <= mapper["merchantIdentifier"]
        self.merchantSecretKey <= mapper["merchantSecretKey"]
        self.readerModel <= mapper["readerModel"]
        self.serverType <= mapper["serverType"]
        self.paymentEnabled <= mapper["paymentEnabled"]
    }
}

class DataManager {
    
    func employeeList(success: (Array<Employee>) -> Void, failure: () -> Void)  {
        success([Employee(id: 0, name: "Pedro", amount: 0), Employee(id: 1,name: "Sanda", amount: 0), Employee(id: 2, name: "David", amount: 0), Employee(id: 3,name: "Per", amount: 0), Employee(id: 4,name: "Michael", amount: 0), Employee(id: 5,name: "Dmitry", amount: 0), Employee(id: 6,name: "David", amount: 0), Employee(id: 7,name: "Ahmed", amount: 0), Employee(id: 8,name: "Abhi", amount: 0), Employee(id: 8,name: "Simon 1.3", amount: 0), Employee(id: 9,name: "Simon 2.0", amount: 0), Employee(id: 10,name: "Thorsten", amount: 0)]);
    }
    
    func drinkList(success: (Array<Drink> -> Void), failure: () -> Void) {
        success([Drink(name:"Mate", cost: 100),Drink(name:"Spezi", cost: 100)])
    }
    
    func pushAmount(employee: Int, amount:Int, success: (Void -> Void), failure: (Void -> Void)) {
        success()
    }
    
    func merchantData(success: (MerchantData) -> Void, failure: () -> Void) {
        success(MerchantData())
    }
}

class RemoteDataManager : DataManager {
    
    override func employeeList(success: (Array<Employee>) -> Void, failure: () -> Void) {
        let manager = AFHTTPRequestOperationManager();
        manager.GET("http://qultures.com/payworks/server.php/employees", parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject?) -> Void in
            let users = Mapper().mapArray(string:operation.responseString, toType: Employee.self)
            success(users)
            }) { (operation, error) -> Void in
                failure()
        }
    }
    
    override func drinkList(success: (Array<Drink> -> Void), failure: () -> Void) {
        let manager = AFHTTPRequestOperationManager();
        manager.GET("http://qultures.com/payworks/server.php/drinks", parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject?) -> Void in
            let drinks = Mapper().mapArray(string:operation.responseString, toType: Drink.self)
            success(drinks)
            }) { (operation, error) -> Void in
                failure()
        }
    }
    
    override func merchantData(success: (MerchantData) -> Void, failure: () -> Void) {
        let manager = AFHTTPRequestOperationManager();
        manager.GET("http://qultures.com/payworks/server.php/merchantData", parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject?) -> Void in
            let merchantData = Mapper().map(string:operation.responseString, toType: MerchantData.self)
            success(merchantData)
            }) { (operation, error) -> Void in
                failure()
        }
    }
    
    override func pushAmount(employee: Int, amount: Int, success: (Void -> Void), failure: (Void -> Void)) {
        let manager = AFHTTPRequestOperationManager();
        manager.POST("http://qultures.com/payworks/server.php/pushAmount", parameters: [ "employee" : employee, "amount" : amount ], success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject?) -> Void in
                success()
            }) { (operation, error) -> Void in
                failure()
        }
    }

}


class EmployeeTableController : UITableViewController {
    
    var employees:Array<Employee>!
    var drinks: Array<Drink>!
    
    var datamanager = RemoteDataManager()
    var merchantData:MerchantData!
    
    override func viewDidLoad() {
        self.employees = []
        datamanager.employeeList({ (employees) -> Void in
            self.employees = employees
            self.tableView.reloadData()
        }, failure: { () -> Void in
            
        })
        
        self.drinks = []
        datamanager.drinkList({ (drinks) -> Void in
            self.drinks = drinks
        }, failure: { () -> Void in
                
        })
        self.merchantData = MerchantData()
        datamanager.merchantData({ (merchantData) -> Void in
            self.merchantData = merchantData
            // TODO: only hide payment Buttons if necessary
            println(merchantData)
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
        println(self.employees[index].title)
        cell.textLabel?.text = self.employees[index].title
        let amtD = Double(self.employees[index].amount) / 100.0
        println(amtD)
        cell.amt.text = String(format: "%.2f €", amtD)
        let button = UIButton();
        button.setTitle("title", forState: .Normal);
        button.tag = indexPath.row
        cell.pay.hidden = !self.merchantData.paymentEnabled
        [cell.addSubview(button)];
        return cell
    }
    
    
    @IBAction func pay(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("pay") as PayController
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet;
        controller.amount = self.employees[sender.tag].amount
        self.presentViewController(controller, animated: true, completion: nil)
        
        controller.onPay = {(success: Bool) -> Void in
            if success {
                self.employees[sender.tag].amount = 0
                let id = self.employees[sender.tag].mid
                self.datamanager.pushAmount(id, amount: 0, success: {} , failure: {
                    let alertController = UIAlertController(title: "Could not reset your amount!", message:
                        "Please contact Korbinian.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: sender.tag, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                self.sort()
            }
        }

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let drinks = DrinksTableController()
        drinks.drinks = self.drinks
        drinks.finished = {(drink:Drink) -> () in
            let newamount = self.employees[indexPath.row].amount + drink.cost
            let id = self.employees[indexPath.row].mid
            let amount = self.employees[indexPath.row].amount
            self.datamanager.pushAmount(id, amount: newamount, success: {
                self.employees[indexPath.row].amount = newamount
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                self.sort()
            }, failure: {
                let alertController = UIAlertController(title: "Could not add drink, try again!", message:
                    nil, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        self.navigationController?.pushViewController(drinks, animated: true);
    }
    
    
    func sort() {
        let unsorted = self.employees
        
        self.employees.sort({ $0.amount > $1.amount })
        
        self.tableView.beginUpdates()
        
        for (index, element) in enumerate(unsorted) {
            let destRow = find(self.employees, element)!
            
            if (destRow != index) {
                let sourceIndexPath = NSIndexPath(forRow: index, inSection: 0)
                let destIndexPath = NSIndexPath(forRow: destRow, inSection: 0)
                self.tableView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destIndexPath)
            }
        }
        self.tableView.endUpdates()
    }
}

class DrinksTableController : UITableViewController {
    
    
    var drinks:Array<Drink>!
    
    var finished: (Drink -> Void)!

    
    override func viewDidLoad() {
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinks.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "identifier";
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as UITableViewCell;
        let index = indexPath.row
        cell.textLabel?.text = self.drinks[index].title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.popViewControllerAnimated(true);
        let drink = self.drinks[indexPath.row]
        self.finished(drink)
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
    
    var successful: Bool = false
    
    var amount: Int = 0
    
    var onPay: (Bool -> Void)!
    
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
                    /*let signatureViewController = nil /* MPBSignatureViewController()*/
                    signatureViewController.merchantName = "Getränke"
                    signatureViewController.amountText = amt + " €"
                    signatureViewController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
                    self.presentViewController(signatureViewController, animated: true, completion: nil)
                    signatureViewController.registerOnPay({ () -> Void in
                        self.paymentProcess.continueWithCustomerSignature(signatureViewController.signature(), verified: true)
                    }, onCancel: { () -> Void in
                        self.paymentProcess.continueWithCustomerSignature(nil, verified: false)
                    })*/
                    println("no sig!")
                case MPTransactionAction.CustomerIdentification:
                    self.paymentProcess.continueWithCustomerIdentityVerified(false)
                default:
                    println("default")
                }
            }, completed: { (process:MPPaymentProcess!, transaction:MPTransaction?, paymentProcessDetails:MPPaymentProcessDetails!) -> Void in
                self.cancel.hidden = true
                self.done.hidden = false
                self.successful = false
                if(transaction?.status == MPTransactionStatus.Approved) {
                    self.receipt.hidden = false
                    self.successful = true
                    self.actualReceipt = process.receiptFactory.customerReceiptForTransaction(transaction)
                    
                }
            })
    }
    
    @IBAction func sned(sender: AnyObject) {
        let controller = MFMailComposeViewController()
        controller.setSubject("payworks Receipt")
        controller.setCcRecipients(["sanda.bozic@payworksmobile.com"])
        controller.setMessageBody(NSString(format: "%@\n%@\n%@\n%@\n\n%@", "payworks GmbH", "Grillparzerstraße 14", "81675 München", "Deutschland", self.actualReceipt.prettyPrinted()), isHTML: false)
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
        self.onPay(self.successful)

    }
    @IBAction func abrot(sender: AnyObject) {
        self.paymentProcess.requestAbort()
    }
}
