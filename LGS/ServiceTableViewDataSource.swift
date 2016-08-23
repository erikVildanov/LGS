//
//  ServiceTableViewDataSource.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ServiceTableViewDataSource: NSObject ,UITableViewDataSource {
    
    var quotes = Quotes()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return quotes.description.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceCell", forIndexPath: indexPath) as! ServiceTableViewCell
        
        cell.information.text = "\(quotes.id[indexPath.row])\n\(quotes.time[indexPath.row])\n\(quotes.rating[indexPath.row])\n\(quotes.description[indexPath.row])"
        return cell
    }
}
