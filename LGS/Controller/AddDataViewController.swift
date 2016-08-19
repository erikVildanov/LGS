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
    private let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
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
        
        let corporateService = CorporateService(context: context)
        
        switch addEditView.customSC.selectedSegmentIndex {
        case 1:
            corporateService.createNewCoWorker(addEditView.fullName.text!,
                                               salary: atof(addEditView.salary.text!),
                                               lunchTime: addEditView.lunchTime.text!,
                                               seatNumber: atof(addEditView.seatNumber.text!))
        case 2:
            corporateService.createNewBookkeeping(addEditView.fullName.text!,
                                                  salary: atof(addEditView.salary.text!),
                                                  businessHours: addEditView.businessHours.text!,
                                                  lunchTime: addEditView.lunchTime.text!,
                                                  seatNumber: atof(addEditView.seatNumber.text!),
                                                  bookkeepingType: addEditView.bookkeepingType.selectedSegmentIndex)
        default:
            corporateService.createNewLeadership(addEditView.fullName.text!,
                                                 salary: atof(addEditView.salary.text!),
                                                 businessHours: addEditView.businessHours.text!)
        }
        
        corporateService.saveChanges()
        
        reloadTableViewData()
        
        defultLable()
    }

    
    private func defultLable(){
        addEditView.fullName.text = ""
        addEditView.salary.text = ""
        addEditView.businessHours.text = ""
        addEditView.seatNumber.text = ""
        addEditView.lunchTime.text = ""
        addEditView.bookkeepingType.selectedSegmentIndex = 0
    }
    
    private func reloadTableViewData(){
        let dataSource = TableDataSource()
        let listViewController = self.navigationController?.viewControllers[0] as! ListViewController
        listViewController.tableData = dataSource
        listViewController.tableView.dataSource = dataSource
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
}


























