//
//  TableView.swift
//  LGS
//
//  Created by Эрик Вильданов on 22.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class TableView: UIView {

    var tableView = UITableView()
    let navigationBar = UINavigationBar()
    let toolBar = UIToolbar()
    
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
        addSubview(tableView)
        addSubview(navigationBar)
        addSubview(toolBar)
        tableView.estimatedRowHeight = 109
        tableView.rowHeight = UITableViewAutomaticDimension
        let viewsDict = [
            "tableView" : tableView,
            "navigationBar" : navigationBar,
            "toolBar" : toolBar
        ]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigationBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[toolBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[navigationBar(60)][tableView][toolBar(50)]|", options: [], metrics: nil, views: viewsDict))
        
    }
    
    
    
}
