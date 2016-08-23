//
//  ServiceViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class TableServiceViewController: UIViewController {
    
    let serviceTableView = ServiceTableView()
    let serviceDataSource = ServiceTableViewDataSource()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTable()
        createToolBarButton()
        view = serviceTableView
        serviceTableView.tableView.registerClass(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        
        loadJson{
            self.serviceTableView.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        }
        serviceTableView.tableView.dataSource = serviceDataSource
    }
    
    func loadJson(completion: (Void -> Void)?){
        let feedJsonParser = FeedJsonParser()
        feedJsonParser.parseFeed("http://quotes.zennex.ru/api/v3/bash/quotes?sort=time", completionHandler:
            {
                (json: Quotes) -> Void in
                self.serviceDataSource.quotes = json
                dispatch_async(dispatch_get_main_queue(), {
                        completion?()
                })
        })
        
    }
    
    func refreshTable(){
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        serviceTableView.tableView.addSubview(refreshControl)
    }

    func refresh() {
        refreshControl.beginRefreshing()
        loadJson {
            self.serviceTableView.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            self.refreshControl.endRefreshing()
        }
    }
    
    func createToolBarButton() {
        serviceTableView.toolBar.items = [
            UIBarButtonItem(title: "Gallery", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpGalleryViewController)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpListViewController)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Service", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        ]
    }
    
    func jumpGalleryViewController(){
        let addFormViewController = GalleryViewController()
        addFormViewController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(addFormViewController, animated: true, completion: nil)
    }
    
    func jumpListViewController(){
        let listViewController = ListViewController()
        listViewController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(listViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
