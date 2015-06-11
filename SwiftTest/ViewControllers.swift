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
    @IBOutlet weak var amt: UILabel!
    @IBOutlet weak var pay: UIButton!
}

class DrinkTableViewCell : UITableViewCell {
    
    @IBOutlet weak var cost: UILabel!
}

class Employee : NSObject {
    var mid = 0
    var title = "fribbu"
    var amount = 0
    
    required override init() {}
    
    init(id:Int, name:String, amount: Int){
        self.mid = id
        self.title = name
        self.amount = amount
    }
    
    
}

class Drink : NSObject {
    var title = ""
    var cost = 100
    var stock = 500
    var did = 0
    var trackStock = false
    
    required override init() {}
    
    init(name:String, cost: Int) {
        self.title = name
        self.cost = cost
   }
    

}


class MerchantData : NSObject {
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
    
    func pushStock(drink: Int, stock: Int, success: (Void -> Void), failure: (Void -> Void)) {
        success()
    }
    
    func merchantData(success: (MerchantData) -> Void, failure: () -> Void) {
        success(MerchantData())
    }
}



class FirebaseDataManager : DataManager {
    
    var employeeRef:Firebase
    
    override init() {
        // Create a reference to a Firebase location
        employeeRef = Firebase(url:"https://amber-fire-1440.firebaseio.com/employees")
        
       
    }
    
    override func employeeList(success: (Array<Employee>) -> Void, failure: () -> Void) {
        // start reading data
        employeeRef.observeEventType(.Value, withBlock: {
            snapshot in
            let enumerator = snapshot.children
            var users:Array<Employee> = []
            while let rest = enumerator.nextObject() as? FDataSnapshot {
                println(rest.value)
                let emp = Employee()
                emp.mid = rest.value["id"] as! Int
                emp.title = rest.value["name"] as! String
                emp.amount = rest.value["amount"] as! Int
                users.append(emp)
            }
            success(users)
        })
    }
    
    override func drinkList(success: (Array<Drink> -> Void), failure: () -> Void) {
        let drinkRef = Firebase(url:"https://amber-fire-1440.firebaseio.com/drinks")
        
        drinkRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            let enumerator = snapshot.children
            var drinks:Array<Drink> = []
            while let drink = enumerator.nextObject() as? FDataSnapshot {
                let drinkA = Drink()
                drinkA.title = drink.value["name"] as! String
                drinkA.cost = drink.value["cost"] as! Int
                drinkA.stock = drink.value["stock"] as! Int
                drinkA.did = drink.value["id"] as! Int
                drinkA.trackStock = drink.value["trackStock"] as! Bool
                drinks.append(drinkA)
            }
            success(drinks)
        })
    }
    
    override func merchantData(success: (MerchantData) -> Void, failure: () -> Void) {
        let merchantDataRef = Firebase(url:"https://amber-fire-1440.firebaseio.com/merchantData")
        
        merchantDataRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            let merchantData = MerchantData()
            merchantData.name = snapshot.value["name"] as! String
            merchantData.street = snapshot.value["street"] as! String
            merchantData.townzip = snapshot.value["townzip"] as! String
            merchantData.country = snapshot.value["country"] as! String
            merchantData.merchantIdentifier = snapshot.value["merchantId"] as! String
            merchantData.merchantSecretKey = snapshot.value["merchantSecretKey"] as! String
            merchantData.readerModel = snapshot.value["readerModel"] as! String
            merchantData.serverType = snapshot.value["serverType"] as! String
            merchantData.paymentEnabled = snapshot.value["paymentEnabled"] as! Bool
            
            success(merchantData)
        })
    }
    
    override func pushAmount(employee: Int, amount: Int, success: (Void -> Void), failure: (Void -> Void)) {
        let pushAmountRef = Firebase(url: "https://amber-fire-1440.firebaseio.com/employees")
        
        let employee = pushAmountRef.childByAppendingPath(String(employee - 1))
        
        var amount = ["amount": amount]
        
        employee.updateChildValues(amount)
    }
    
    override func pushStock(drink: Int, stock: Int, success: (Void -> Void), failure: (Void -> Void)) {
        let pushAmountRef = Firebase(url: "https://amber-fire-1440.firebaseio.com/drinks")
        
        let drink = pushAmountRef.childByAppendingPath(String(drink))
        
        var stock = ["stock": stock]
        
        drink.updateChildValues(stock)
    }
}


class EmployeeTableController : UITableViewController {
    
    var employees:Array<Employee>!
    var drinks: Array<Drink>!
    
    var datamanager = FirebaseDataManager()
    var merchantData:MerchantData!
    
    override func viewDidLoad() {
        self.employees = []
        datamanager.employeeList({ (employees) -> Void in
            let oldEmployees = self.employees
            self.employees = employees
            self.tableView.reloadData()
            self.sort(oldEmployees)
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
            self.sort(self.employees)
        }, failure: { () -> Void in
            
        })
        
        MPMpos.setLogLevel(16)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "identifier";
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as! CustomTableViewCell;
        let index = indexPath.row
        println(self.employees[index].title)
        cell.textLabel?.text = self.employees[index].title
        let amtD = Double(self.employees[index].amount) / 100.0
        println(amtD)
        cell.amt.text = String(format: "%.2f €", amtD)
        let button = UIButton();
        button.setTitle("title", forState: .Normal);
        cell.pay.hidden = !self.merchantData.paymentEnabled || amtD <= 0.0
        cell.tag = self.employees[index].mid
        [cell.addSubview(button)];
        return cell
    }
    
    
    @IBAction func pay(sender: AnyObject) {
        let buttonPosition = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(buttonPosition)!
        
        let amount = self.employees[indexPath.row].amount
        let controller = MPUMposUi.initializeWithProviderMode(merchantData.serverType == "LIVE" ? MPProviderMode.LIVE : MPProviderMode.TEST, merchantIdentifier: merchantData.merchantIdentifier, merchantSecret: merchantData.merchantSecretKey) as! MPUMposUi

        controller.configuration.accessoryFamily = MPAccessoryFamily.MiuraMPI
        controller.configuration.receiptMethod = MPUMposUiConfigurationReceiptMethod.ReadyMade;
        let viewController = controller.createChargeTransactionViewControllerWithAmount(NSDecimalNumber(double: Double(amount) / 100.0), currency: MPCurrency.EUR, subject: "subject", customIdentifier: "customIdentifier") { (me, result, tx) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            if (result == MPUMposUiTransactionResult.Approved) {
                self.employees[indexPath.row].amount = 0
                let id = self.employees[indexPath.row].mid
                self.datamanager.pushAmount(id, amount: 0, success: {} , failure: {
                })
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                self.sort(self.employees)
            } else {
            }
        }
        
        let modalNav = UINavigationController(rootViewController: viewController)
        modalNav.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(modalNav, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let drinks = self.storyboard?.instantiateViewControllerWithIdentifier("drinksController") as! DrinksTableController
        drinks.drinks = self.drinks
        drinks.finished = {(drink:Drink) -> () in
            let newamount = self.employees[indexPath.row].amount + drink.cost
            let id = self.employees[indexPath.row].mid
            let amount = self.employees[indexPath.row].amount
            self.datamanager.pushAmount(id, amount: newamount, success: {
                self.employees[indexPath.row].amount = newamount
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                self.sort(self.employees)
            }, failure: {
                let alertController = UIAlertController(title: "Could not add drink, try again!", message:
                    nil, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            })
            
            if(drink.trackStock) {
                self.datamanager.pushStock(drink.did, stock: drink.stock-1, success: {
            
                    }, failure: {
                    
                });
            }
        }
        self.navigationController?.pushViewController(drinks, animated: true);
    }
    
    func findEmployeeIndexById(employees: Array<Employee>, id:Int) -> Int? {
        for employee in employees {
            if(employee.mid == id) {
                return find(employees, employee)
            }
        }
        return nil
    }
    
    
    func sort(oldEmployees: Array<Employee>) {
        let unsorted = self.employees
        
        println(oldEmployees)
        println(self.employees)
        
        self.employees.sort({ $0.amount > $1.amount })
        
        self.tableView.beginUpdates()
        
        for (index, element) in enumerate(unsorted) {
            let sourceRow = self.findEmployeeIndexById(oldEmployees, id: element.mid) ?? index
            let destRow = find(self.employees, element)!
            
            if (destRow != sourceRow) {
                let sourceIndexPath = NSIndexPath(forRow: sourceRow, inSection: 0)
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
        let cell = (tableView.dequeueReusableCellWithIdentifier(identifier) ?? DrinkTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)) as! DrinkTableViewCell;
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


