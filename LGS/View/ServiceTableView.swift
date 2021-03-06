//
//  ServiceTableView.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ServiceTableView: UIView {
    
    var tableView = UITableView()
    let navigationBar = UINavigationBar()
    let toolBar = UIToolbar()
    let statusBar = UIView()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        initializeView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(){
        
        let navItem = UINavigationItem(title: "Service")
        navigationBar.setItems([navItem], animated: false)
        addSubview(tableView)
        addSubview(navigationBar)
        addSubview(toolBar)
        addSubview(statusBar)
        statusBar.backgroundColor = UIColor.blackColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        tableView.estimatedRowHeight = 109
        tableView.rowHeight = UITableViewAutomaticDimension
        let viewsDict = [
            "tableView" : tableView,
            "navigationBar" : navigationBar,
            "toolBar" : toolBar,
            "statusBar": statusBar
        ]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigationBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[toolBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[statusBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[statusBar(20)][navigationBar(44)][tableView][toolBar(50)]|", options: [], metrics: nil, views: viewsDict))
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(deviceDidRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func deviceDidRotate(notification: NSNotification)
    {
        UIApplication.sharedApplication().statusBarHidden = false
    }
}
