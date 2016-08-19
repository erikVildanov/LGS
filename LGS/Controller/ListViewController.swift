//
//  ViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    
    var tableView = UITableView()
    var tableData = TableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 109
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = tableData
        tableView.delegate = self
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
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(ListViewController.openEdit))
        
        self.navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(image: UIImage(named: "Plus"), style: .Plain, target: self, action: #selector(addNewItem))
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let editDataViewController = EditDataViewController(leadership: self.tableData.leadership[indexPath.row], index: indexPath.row)
            self.navigationController?.pushViewController(editDataViewController, animated: true)
        }
        if indexPath.section == 1 {
            let editDataViewController = EditDataViewController(coWorker: self.tableData.coWorker[indexPath.row], index: indexPath.row)
            self.navigationController?.pushViewController(editDataViewController, animated: true)
        }
        if indexPath.section == 2 {
            let editDataViewController = EditDataViewController(bookkeeping: self.tableData.bookkeeping[indexPath.row], index: indexPath.row)
            self.navigationController?.pushViewController(editDataViewController, animated: true)
        }
    }
}

















