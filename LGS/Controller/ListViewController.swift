//
//  ViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    
    var tableData = TableDataSource()
    let viewTable = TableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTable.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        viewTable.tableView.dataSource = tableData
        viewTable.tableView.delegate = self
        view = viewTable
        createBarButton()
        createToolBarButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createBarButton() {
        let navItem = UINavigationItem(title: "List")
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(ListViewController.openEdit))
        navItem.leftBarButtonItem = editButton
        let addButton = UIBarButtonItem(image: UIImage(named: "Plus"), style: .Plain, target: self, action: #selector(ListViewController.addNewItem))
        navItem.rightBarButtonItem = addButton
        viewTable.navigationBar.setItems([navItem], animated: false)
    }
    
    func createToolBarButton() {
        
        
        
        viewTable.toolBar.items = [
            UIBarButtonItem(title: "Gallery", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpGalleryViewController)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Service", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpServiceViewController))
        ]
    }
    
    func jumpGalleryViewController(){
        let addFormViewController = GalleryViewController()
        addFormViewController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(addFormViewController, animated: true, completion: nil)
    }
    
    func jumpServiceViewController(){

    }
    
    var flag = true
    func openEdit(){
        if flag {
            viewTable.tableView.editing = true
            flag = false
        } else {
            viewTable.tableView.editing = false
            flag = true
        }
    }
    
    func addNewItem(){
        let addFormViewController = AddDataViewController()
        addFormViewController.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(addFormViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let editDataViewController = EditDataViewController(leadership: self.tableData.leadership[indexPath.row], index: indexPath.row)
            editDataViewController.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(editDataViewController, animated: true, completion: nil)
        }
        if indexPath.section == 1 {
            let editDataViewController = EditDataViewController(coWorker: self.tableData.coWorker[indexPath.row], index: indexPath.row)
            editDataViewController.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(editDataViewController, animated: true, completion: nil)
        }
        if indexPath.section == 2 {
            let editDataViewController = EditDataViewController(bookkeeping: self.tableData.bookkeeping[indexPath.row], index: indexPath.row)
            editDataViewController.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(editDataViewController, animated: true, completion: nil)
        }
    }
}














