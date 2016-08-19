//
//  AddEditView.swift
//  LGS
//
//  Created by Эрик Вильданов on 19.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class AddEditView: UIView {
    
    var customSC: UISegmentedControl!
    var fullName = UITextField()
    var salary = UITextField()
    var businessHours = UITextField()
    var seatNumber = UITextField()
    var lunchTime = UITextField()
    var bookkeepingType = UISegmentedControl()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        initializeSegmentedControll()
        initializeCorporateViews()
        setupLeadershipView()
        initializeKeyboardType()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeKeyboardType(){
        fullName.keyboardType = .Default
        salary.keyboardType = .NumbersAndPunctuation
        businessHours.keyboardType = .NumbersAndPunctuation
        seatNumber.keyboardType = .NumbersAndPunctuation
        lunchTime.keyboardType = .NumbersAndPunctuation
    }
    
    private func initializeSegmentedControll(){
        let items = ["Руководство","Сотрудник","Бухгалтер"]
        customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 5.0
        customSC.translatesAutoresizingMaskIntoConstraints = false
        customSC.backgroundColor = UIColor.blackColor()
        customSC.tintColor = UIColor.yellowColor()
        customSC.addTarget(self, action: #selector(AddEditView.changeEmployees(_:)), forControlEvents: .ValueChanged)
        addSubview(customSC)
        let viewsDict = ["customSC" : customSC]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[customSC]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-70-[customSC(60)]", options: [], metrics: nil, views: viewsDict))
    }
    
    private func initializeCorporateViews(){
        fullName.translatesAutoresizingMaskIntoConstraints = false
        salary.translatesAutoresizingMaskIntoConstraints = false
        fullName.becomeFirstResponder()
        fullName.backgroundColor = UIColor.grayColor()
        salary.backgroundColor = UIColor.grayColor()
        fullName.borderStyle = .RoundedRect
        salary.borderStyle = .RoundedRect
        fullName.placeholder = "ФИО"
        salary.placeholder = "Зарплата"
        addSubview(fullName)
        addSubview(salary)
        let viewsDict = [ "customSC" : customSC, "fullName" : fullName, "salary" : salary]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[fullName]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[customSC(60)]-8-[fullName(30)]-8-[salary(30)]", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[salary]-10-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func setupLeadershipView(){
        businessHours.translatesAutoresizingMaskIntoConstraints = false
        businessHours.borderStyle = .RoundedRect
        businessHours.backgroundColor = UIColor.grayColor()
        businessHours.placeholder = "Часы приема"
        addSubview(businessHours)
        let viewsDict = ["salary" : salary, "businessHours" : businessHours]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[businessHours]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[salary]-8-[businessHours(30)]", options: [], metrics: nil, views: viewsDict))
    }
    
    func setupCoWorkerView(){
        seatNumber.translatesAutoresizingMaskIntoConstraints = false
        lunchTime.translatesAutoresizingMaskIntoConstraints = false
        seatNumber.borderStyle = .RoundedRect
        lunchTime.borderStyle = .RoundedRect
        seatNumber.backgroundColor = UIColor.grayColor()
        lunchTime.backgroundColor = UIColor.grayColor()
        seatNumber.placeholder = "Рабочее место"
        lunchTime.placeholder = "Обеденнове время"
        addSubview(seatNumber)
        addSubview(lunchTime)
        let viewsDict = ["salary" : salary, "seatNumber" : seatNumber, "lunchTime" : lunchTime]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[seatNumber]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[salary]-8-[seatNumber(30)]", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[lunchTime]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[seatNumber]-8-[lunchTime(30)]", options: [], metrics: nil, views: viewsDict))
    }
    
    func setupBookkeepingView(){
        setupCoWorkerView()
        
        let items = ["начисление зарплаты","учет материалов"]
        bookkeepingType = UISegmentedControl(items: items)
        bookkeepingType.selectedSegmentIndex = 0
        bookkeepingType.layer.cornerRadius = 5.0
        bookkeepingType.translatesAutoresizingMaskIntoConstraints = false
        bookkeepingType.backgroundColor = UIColor.blackColor()
        bookkeepingType.tintColor = UIColor.yellowColor()
        addSubview(bookkeepingType)
        let viewsDict = ["lunchTime" : lunchTime, "bookkeepingType" : bookkeepingType]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[bookkeepingType]-10-|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lunchTime]-8-[bookkeepingType(40)]", options: [], metrics: nil, views: viewsDict))
        
    }
    
    func changeEmployees(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            bookkeepingType.removeFromSuperview()
            businessHours.removeFromSuperview()
            setupCoWorkerView()
        case 2:
            businessHours.removeFromSuperview()
            setupBookkeepingView()
        default:
            seatNumber.removeFromSuperview()
            lunchTime.removeFromSuperview()
            bookkeepingType.removeFromSuperview()
            setupLeadershipView()
        }
    }

}
