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
    
    private var customSC: UISegmentedControl!
    private var fullName = UITextField()
    private var salary = UITextField()
    private var businessHours = UITextField()
    private var seatNumber = UITextField()
    private var lunchTime = UITextField()
    private var bookkeepingType = UITextField()
    private var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        initializeSegmentedControll()
        initializeCorporateViews()
        setupLeadershipView()
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(AddDataViewController.saveData))
        
        self.navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func initializeSegmentedControll(){
        let items = ["Руководство","Сотрудник","Бухгалтер"]
        customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 5.0
        customSC.translatesAutoresizingMaskIntoConstraints = false
        customSC.backgroundColor = UIColor.blackColor()
        customSC.tintColor = UIColor.yellowColor()
        customSC.addTarget(self, action: #selector(AddDataViewController.changeColor(_:)), forControlEvents: .ValueChanged)
        view.addSubview(customSC)
        let viewsDict = ["customSC" : customSC]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[customSC]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[customSC(60)]", options: [], metrics: nil, views: viewsDict))
    }
    
    private func initializeCorporateViews(){
        fullName.translatesAutoresizingMaskIntoConstraints = false
        salary.translatesAutoresizingMaskIntoConstraints = false
        fullName.backgroundColor = UIColor.grayColor()
        salary.backgroundColor = UIColor.grayColor()
        fullName.borderStyle = .RoundedRect
        salary.borderStyle = .RoundedRect
        fullName.placeholder = "ФИО"
        salary.placeholder = "Зарплата"
        view.addSubview(fullName)
        view.addSubview(salary)
        let viewsDict = [ "customSC" : customSC, "fullName" : fullName, "salary" : salary]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[fullName]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[customSC(60)]-8-[fullName(30)]-8-[salary(30)]", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[salary]-10-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func changeColor(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            index = 1
            bookkeepingType.removeFromSuperview()
            businessHours.removeFromSuperview()
            setupCoWorkerView()
        case 2:
            index = 2
            businessHours.removeFromSuperview()
            setupBookkeepingView()
        default:
            index = 0
            seatNumber.removeFromSuperview()
            lunchTime.removeFromSuperview()
            bookkeepingType.removeFromSuperview()
            setupLeadershipView()
        }
    }
    
    private func setupLeadershipView(){
        businessHours.translatesAutoresizingMaskIntoConstraints = false
        businessHours.borderStyle = .RoundedRect
        businessHours.backgroundColor = UIColor.grayColor()
        businessHours.placeholder = "Часы приема"
        view.addSubview(businessHours)
        let viewsDict = ["salary" : salary, "businessHours" : businessHours]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[businessHours]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[salary]-8-[businessHours(30)]", options: [], metrics: nil, views: viewsDict))
    }
    
    private func setupCoWorkerView(){
        seatNumber.translatesAutoresizingMaskIntoConstraints = false
        lunchTime.translatesAutoresizingMaskIntoConstraints = false
        seatNumber.borderStyle = .RoundedRect
        lunchTime.borderStyle = .RoundedRect
        seatNumber.backgroundColor = UIColor.grayColor()
        lunchTime.backgroundColor = UIColor.grayColor()
        seatNumber.placeholder = "Рабочее место"
        lunchTime.placeholder = "Обеденнове время"
        view.addSubview(seatNumber)
        view.addSubview(lunchTime)
        let viewsDict = ["salary" : salary, "seatNumber" : seatNumber, "lunchTime" : lunchTime]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[seatNumber]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[salary]-8-[seatNumber(30)]", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[lunchTime]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[seatNumber]-8-[lunchTime(30)]", options: [], metrics: nil, views: viewsDict))
    }
    
    private func setupBookkeepingView(){
        setupCoWorkerView()
        bookkeepingType.translatesAutoresizingMaskIntoConstraints = false
        bookkeepingType.borderStyle = .RoundedRect
        bookkeepingType.backgroundColor = UIColor.grayColor()
        bookkeepingType.placeholder = "тип Бухгалтера"
        view.addSubview(bookkeepingType)
        let viewsDict = ["lunchTime" : lunchTime, "bookkeepingType" : bookkeepingType]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[bookkeepingType]-10-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lunchTime]-8-[bookkeepingType(30)]", options: [], metrics: nil, views: viewsDict))
        
    }
    
    func saveData() {
        if self.fullName.text == "" && self.salary.text == "" && self.businessHours.text == "" {
            let alertController = UIAlertController(title: "Ooops", message: "Не все поля заполнены", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        switch index {
        case 1:
            let coWorker = NSEntityDescription.insertNewObjectForEntityForName("CoWorker", inManagedObjectContext: managedObjectContext) as! CoWorker
            coWorker.fullName = self.fullName.text
            if let salary = self.salary.text {
                coWorker.salary = atof(salary)
            }
            if let lunchTime = self.lunchTime.text {
                coWorker.lunchTime = atof(lunchTime)
            }
            if let seatNumber = self.seatNumber.text {
                coWorker.seatNumber = atof(seatNumber)
            }
            
        case 2:
            let bookkeeping = NSEntityDescription.insertNewObjectForEntityForName("Bookkeeping", inManagedObjectContext: managedObjectContext) as! Bookkeeping
            bookkeeping.fullName = self.fullName.text
            if let salary = self.salary.text {
                bookkeeping.salary = atof(salary)
            }
            if let lunchTime = self.lunchTime.text {
                bookkeeping.lunchTime = atof(lunchTime)
            }
            if let seatNumber = self.seatNumber.text {
                bookkeeping.seatNumber = atof(seatNumber)
            }
            bookkeeping.bookkeepingType = self.bookkeepingType.text
        default:
            let leadership = NSEntityDescription.insertNewObjectForEntityForName("Leadership", inManagedObjectContext: managedObjectContext) as! Leadership
            leadership.fullName = self.fullName.text
            if let salary = self.salary.text {
                leadership.salary = atof(salary)
            }
            if let businessHours = self.businessHours.text {
                leadership.businessHours = atof(businessHours)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
            return
        }
        
        self.fullName.text = ""
        self.salary.text = ""
        self.businessHours.text = ""
        self.seatNumber.text = ""
        self.lunchTime.text = ""
        self.bookkeepingType.text = ""
        
    }
    
}
