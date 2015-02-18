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
import MPBSignatureViewController

class CustomTableViewCell : UITableViewCell {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var amt: UILabel!
    @IBOutlet weak var pay: UIButton!
}

class DrinkTableViewCell : UITableViewCell {
    
    @IBOutlet weak var cost: UILabel!
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
        self.merchantIdentifier <= mapper["merchantId"]
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
            println(operation.responseString)
            println(users)
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
            self.sort()
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
            self.sort()
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
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(buttonPosition)!
        
        let amount = self.employees[indexPath.row].amount
        let controller = MPUPaymentController.initializePaymentControllerWithProviderMode(merchantData.serverType == "LIVE" ? MPProviderMode.LIVE : MPProviderMode.TEST, merchantIdentifier: merchantData.merchantIdentifier, merchantSecret: merchantData.merchantSecretKey) as MPUPaymentController
        
        controller.configuration.accessoryFamily = MPAccessoryFamily.MiuraMPI
        let viewController = controller.createPaymentViewControllerWithAmount(NSDecimalNumber(double: Double(amount) / 100.0), currency: MPCurrency.EUR, subject: "subject", customIdentifier: "customIdentifier") { (result, tx) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            if (result == MPUPaymentControllerResult.Approved) {
                self.employees[indexPath.row].amount = 0
                let id = self.employees[indexPath.row].mid
                self.datamanager.pushAmount(id, amount: 0, success: {} , failure: {
                })
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                self.sort()
            } else {
                let alertController = UIAlertController(title: "You did not pay!", message:
                    "If you think this was due to an error, contact Korbinian.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
        let modalNav = UINavigationController(rootViewController: viewController)
        modalNav.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(modalNav, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let drinks = self.storyboard?.instantiateViewControllerWithIdentifier("drinksController") as DrinksTableController
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
        let identifier = "identifierElse";
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? DrinkTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as DrinkTableViewCell;
        let index = indexPath.row
        cell.textLabel?.text = self.drinks[index].title
        cell.cost.text = String(format: "%.2f €", Double(self.drinks[index].cost) / 100.0)
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


