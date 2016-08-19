//
//  EditDataViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 19.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit
import CoreData

class EditDataViewController: UIViewController {
    
    let addEditView = AddEditView()
    private var section = 0
    private var index = 0
    private let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addEditView
        
        let saveButton = UIBarButtonItem(title: "Update", style: .Plain, target: self, action: #selector(EditDataViewController.updateData))
        
        self.navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }
    
    init(leadership: Leadership, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        self.section = 0
        addEditView.customSC.selectedSegmentIndex = 0
        addEditView.setupLeadershipView()
        addEditView.fullName.text = leadership.fullName
        addEditView.salary.text! = "\(leadership.salary!)"
        addEditView.businessHours.text = leadership.businessHours
    }
    
    init(coWorker: CoWorker, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        self.section = 1
        addEditView.customSC.selectedSegmentIndex = 1
        addEditView.setupCoWorkerView()
        addEditView.fullName.text = coWorker.fullName
        addEditView.salary.text = "\(coWorker.salary!)"
        addEditView.lunchTime.text = coWorker.lunchTime
        addEditView.seatNumber.text = "\(coWorker.seatNumber!)"
    }
    
    init(bookkeeping: Bookkeeping, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        self.section = 2
        addEditView.customSC.selectedSegmentIndex = 2
        addEditView.setupBookkeepingView()
        addEditView.fullName.text = bookkeeping.fullName
        addEditView.salary.text = "\(bookkeeping.salary!)"
        addEditView.lunchTime.text = bookkeeping.lunchTime
        addEditView.seatNumber.text = "\(bookkeeping.seatNumber!)"
        addEditView.bookkeepingType.selectedSegmentIndex = (bookkeeping.bookkeepingType?.integerValue)!
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(){
        
        let corporateService = CorporateService(context: context)
        
        switch addEditView.customSC.selectedSegmentIndex {
        case 1:
            updateCoWorker(corporateService)
        case 2:
            updateBookkeeping(corporateService)
        default:
            updateLeadership(corporateService)
        }
        reloadTableViewData()
        corporateService.saveChanges()
    }
    
    private func reloadTableViewData(){
        let dataSource = TableDataSource()
        let listViewController = self.navigationController?.viewControllers[0] as! ListViewController
        listViewController.tableData = dataSource
        listViewController.tableView.dataSource = dataSource
        self.navigationController!.popToRootViewControllerAnimated(true)
    }

    func updateLeadership(corporateService: CorporateService){
        var readLeadership : [Leadership] = corporateService.getAllLeadership()
        
        if section == 0 {
            if let updateLeadership = corporateService.getByIdLeadership(readLeadership[index].objectID) {
                updateLeadership.fullName = addEditView.fullName.text
                updateLeadership.salary = atof(addEditView.salary.text!)
                updateLeadership.businessHours = addEditView.businessHours.text
                corporateService.updateLeadership(updateLeadership)
            }
        } else {
            crateData(addEditView.customSC.selectedSegmentIndex)
            deleteData(section)
            
        }
    }
    
    func updateBookkeeping(corporateService: CorporateService){
        var readBookkeeping : [Bookkeeping] = corporateService.getAllBookkeeping()
        
        if section == 2 {
            if let updateBookkeeping = corporateService.getByIdBookkeeping(readBookkeeping[index].objectID) {
                updateBookkeeping.fullName = addEditView.fullName.text
                updateBookkeeping.salary = atof(addEditView.salary.text!)
                updateBookkeeping.lunchTime = addEditView.lunchTime.text
                updateBookkeeping.seatNumber = atof(addEditView.seatNumber.text!)
                updateBookkeeping.bookkeepingType = addEditView.bookkeepingType.selectedSegmentIndex
                corporateService.updateBookkeeping(updateBookkeeping)
            }
        } else {
            crateData(addEditView.customSC.selectedSegmentIndex)
            deleteData(section)
        }
    }
    
    func updateCoWorker(corporateService: CorporateService){
        var readCoWorker : [CoWorker] = corporateService.getAllCoWorker()
        
        if section == 1 {
            if let updateCoWorker = corporateService.getByIdCoWorker(readCoWorker[index].objectID) {
                updateCoWorker.fullName = addEditView.fullName.text
                updateCoWorker.salary = atof(addEditView.salary.text!)
                updateCoWorker.lunchTime = addEditView.lunchTime.text
                updateCoWorker.seatNumber = atof(addEditView.seatNumber.text!)
                
                corporateService.updateCoWorker(updateCoWorker)
            }
        } else {
            crateData(addEditView.customSC.selectedSegmentIndex)
            deleteData(section)
        }
    }
    
    
    func crateData(section: Int){
        
        checkLable(section)
        
        let corporateService = CorporateService(context: context)
        
        switch section {
        case 1:
            corporateService.createNewCoWorker(addEditView.fullName.text!, salary: atof(addEditView.salary.text!), lunchTime: addEditView.lunchTime.text!, seatNumber: atof(addEditView.seatNumber.text!))
        case 2:
            corporateService.createNewBookkeeping(addEditView.fullName.text!, salary: atof(addEditView.salary.text!), businessHours: addEditView.businessHours.text!, lunchTime: addEditView.lunchTime.text!, seatNumber: atof(addEditView.seatNumber.text!), bookkeepingType: addEditView.bookkeepingType.selectedSegmentIndex)
        default:
            corporateService.createNewLeadership(addEditView.fullName.text!, salary: atof(addEditView.salary.text!),  businessHours: addEditView.businessHours.text!)
        }
        corporateService.saveChanges()
        reloadTableViewData()
    }
    
    func deleteData(section: Int){
        
        let corporateService = CorporateService(context: context)
        
        switch section {
        case 1:
            var readCoWorker : [CoWorker] = corporateService.getAllCoWorker()
            let deleteCoWorker = corporateService.getByIdCoWorker(readCoWorker[index].objectID)!
            corporateService.deleteCoWorker(deleteCoWorker.objectID)
            readCoWorker.removeAtIndex(index)
        case 2:
            var readBookkeeping : [Bookkeeping] = corporateService.getAllBookkeeping()
            let deleteBookkeeping = corporateService.getByIdBookkeeping(readBookkeeping[index].objectID)!
            corporateService.deleteBookkeeping(deleteBookkeeping.objectID)
            readBookkeeping.removeAtIndex(index)
        default:
            var readLeadership : [Leadership] = corporateService.getAllLeadership()
            let deleteLeadership = corporateService.getByIdLeadership(readLeadership[index].objectID)!
            corporateService.deleteLeadership(deleteLeadership.objectID)
            readLeadership.removeAtIndex(index)
        }
        corporateService.saveChanges()
        reloadTableViewData()
        

    }
    
    func checkLable(section: Int){
        switch section {
        case 0:
        if addEditView.fullName.text == "" && addEditView.salary.text == "" && addEditView.businessHours.text == "" {
            let alertController = UIAlertController(title: "Ooops", message: "Не все поля заполнены", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        default:
            if addEditView.fullName.text == "" && addEditView.salary.text == "" && addEditView.lunchTime.text == "" && addEditView.seatNumber.text == "" {
                let alertController = UIAlertController(title: "Ooops", message: "Не все поля заполнены", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
    }
    
}









































