//
//  AddDataViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController {
    
    let addEditView = AddEditView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addEditView
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(AddDataViewController.saveData))

        self.navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveData() {
        
        if addEditView.fullName.text == "" && addEditView.salary.text == "" && addEditView.businessHours.text == "" {
            let alertController = UIAlertController(title: "Ooops", message: "Не все поля заполнены", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        switch addEditView.customSC.selectedSegmentIndex {
        case 1:
            let coWorker = NSEntityDescription.insertNewObjectForEntityForName("CoWorker", inManagedObjectContext: managedObjectContext) as! CoWorker
            coWorker.fullName = addEditView.fullName.text
            if let salary = addEditView.salary.text {
                coWorker.salary = atof(salary)
            }
            if let lunchTime = addEditView.lunchTime.text {
                coWorker.lunchTime = lunchTime
            }
            if let seatNumber = addEditView.seatNumber.text {
                coWorker.seatNumber = atof(seatNumber)
            }
            
        case 2:
            let bookkeeping = NSEntityDescription.insertNewObjectForEntityForName("Bookkeeping", inManagedObjectContext: managedObjectContext) as! Bookkeeping
            bookkeeping.fullName = addEditView.fullName.text
            if let salary = addEditView.salary.text {
                bookkeeping.salary = atof(salary)
            }
            if let lunchTime = addEditView.lunchTime.text {
                bookkeeping.lunchTime = lunchTime
            }
            if let seatNumber = addEditView.seatNumber.text {
                bookkeeping.seatNumber = atof(seatNumber)
            }
            bookkeeping.bookkeepingType = addEditView.bookkeepingType.selectedSegmentIndex
        default:
            let leadership = NSEntityDescription.insertNewObjectForEntityForName("Leadership", inManagedObjectContext: managedObjectContext) as! Leadership
            leadership.fullName = addEditView.fullName.text
            if let salary = addEditView.salary.text {
                leadership.salary = atof(salary)
            }
            if let businessHours = addEditView.businessHours.text {
                leadership.businessHours = businessHours
            }
        }
        
        let dataSource = TableDataSource()
        let viewController = self.navigationController?.viewControllers[0] as! ViewController
        viewController.tableData = dataSource
        viewController.tableView.dataSource = dataSource
        self.navigationController!.popToRootViewControllerAnimated(true)
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
            return
        }
        
        addEditView.fullName.text = ""
        addEditView.salary.text = ""
        addEditView.businessHours.text = ""
        addEditView.seatNumber.text = ""
        addEditView.lunchTime.text = ""
        addEditView.bookkeepingType.selectedSegmentIndex = 0
        
    }
    
}
