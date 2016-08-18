//
//  EditDataViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 19.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class EditDataViewController: UIViewController {
    
    let addEditView = AddEditView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addEditView
        // Do any additional setup after loading the view.
    }
    
    convenience init() {
        self.init(leadership: nil)
    }
    
    init(leadership: Leadership?) {
        super.init(nibName: nil, bundle: nil)
        addEditView.customSC.selectedSegmentIndex = 0
        addEditView.setupLeadershipView()
        addEditView.fullName.text = leadership?.fullName
        addEditView.salary.text! = "\(leadership?.salary)"
        addEditView.businessHours.text = leadership?.businessHours
    }
    
    init(coWorker: CoWorker?) {
        super.init(nibName: nil, bundle: nil)
        addEditView.customSC.selectedSegmentIndex = 1
        addEditView.setupCoWorkerView()
        addEditView.fullName.text = coWorker?.fullName
        addEditView.salary.text = "\(coWorker?.salary)"
        addEditView.lunchTime.text = coWorker?.lunchTime
        addEditView.seatNumber.text = "\(coWorker?.seatNumber)"
    }
    
    init(bookkeeping: Bookkeeping?) {
        super.init(nibName: nil, bundle: nil)
        addEditView.customSC.selectedSegmentIndex = 2
        addEditView.setupBookkeepingView()
        addEditView.fullName.text = bookkeeping?.fullName
        addEditView.salary.text = "\(bookkeeping?.salary)"
        addEditView.lunchTime.text = bookkeeping?.lunchTime
        addEditView.seatNumber.text = "\(bookkeeping?.seatNumber)"
        addEditView.bookkeepingType.selectedSegmentIndex = (bookkeeping?.bookkeepingType?.integerValue)!
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
