//
//  ViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView()
    let tableData = TableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = tableData
        self.view.addSubview(tableView)
        setupConstraints()
        createEditButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict = ["tableView" : tableView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: [], metrics: nil, views: viewsDict))
    }
    
    func createEditButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(ViewController.openEdit))
        
        self.navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(image: UIImage(named: "Plus"), style: .Plain, target: self, action: #selector(ViewController.addNewItem))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    var flag = true
    
    func openEdit(){
        if flag {
            tableView.editing = true
            flag = false
        } else {
            tableView.editing = false
            flag = true
        }
    }
    
    func addNewItem(){
        let addFormViewController = AddDataViewController()
        self.navigationController?.pushViewController(addFormViewController, animated: true)
    }


}

