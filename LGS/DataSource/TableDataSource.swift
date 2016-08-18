//
//  TableDataSource.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit
import CoreData

class TableDataSource: NSObject ,UITableViewDataSource {
    
    var leadership: [Leadership] = []
    var coWorker:[CoWorker] = []
    var bookkeeping:[Bookkeeping] = []
    
    override init() {
        super.init()
        var nameData = ["Leadership", "CoWorker", "Bookkeeping"]
        for i in 0..<3 {
            let fetchRequest = NSFetchRequest(entityName: nameData[i])
            let sortDescriptor = NSSortDescriptor(key: "fullName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            if let managerObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                if i == 0 {
                    let fetchedResultsController = (try? managerObjectContext.executeFetchRequest(fetchRequest)) as? [Leadership]
                    leadership = fetchedResultsController!
                }
                if i == 1 {
                    let fetchedResultsController = (try? managerObjectContext.executeFetchRequest(fetchRequest)) as? [CoWorker]
                    coWorker = fetchedResultsController!
                }
                if i == 2 {
                    let fetchedResultsController = (try? managerObjectContext.executeFetchRequest(fetchRequest)) as? [Bookkeeping]
                    bookkeeping = fetchedResultsController!
                }
            }
        }
        
    }
    
    func makeAttributedString(title title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), NSForegroundColorAttributeName: UIColor.blackColor()]
        let subtitleAttributes = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        titleString.appendAttributedString(subtitleString)
        
        return titleString
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0) {
            return leadership.count
        }
        if (section == 1) {
            return coWorker.count
        } else {
            return bookkeeping.count
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0) {
            return "Руководство"
        }
        if (section == 1) {
            return "Сотрудник"
        } else {
            return "Бухгалтерия"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.iconImage.image = UIImage(named: "avatar")
        
        if indexPath.section == 0 {
            cell.information.attributedText = makeAttributedString(title: leadership[indexPath.row].fullName!, subtitle: "Часы приема: \(leadership[indexPath.row].businessHours!)\n Зарплата: \(String(leadership[indexPath.row].salary!))")
        }
        
        if indexPath.section == 1 {
            cell.information.attributedText = makeAttributedString(title: coWorker[indexPath.row].fullName!, subtitle: "Обед: \(coWorker[indexPath.row].lunchTime!)\n Номер рабочего места: \(coWorker[indexPath.row].seatNumber!)\n Зарплата: \(coWorker[indexPath.row].salary!)")
        }
        
        if indexPath.section == 2 {
            var type = String()
            if bookkeeping[indexPath.row].bookkeepingType == 0 {
                type = "начисление зарплаты"
            } else {
                type = "учет материалов"
            }
            
            cell.information.attributedText = makeAttributedString(title: bookkeeping[indexPath.row].fullName!, subtitle: "Обед: \(bookkeeping[indexPath.row].lunchTime!)\n Номер рабочего места: \(bookkeeping[indexPath.row].seatNumber!)\n Зарплата: \(bookkeeping[indexPath.row].salary!)\n Тип бухгалтера: \(type)")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if tableView.editing { return true }
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managerObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        switch editingStyle {
        case .Delete:
            if indexPath.section == 0 {
                managerObjectContext!.deleteObject(leadership[indexPath.row] )
                leadership.removeAtIndex(indexPath.row)
            }
            if indexPath.section == 1 {
                managerObjectContext!.deleteObject(coWorker[indexPath.row] )
                coWorker.removeAtIndex(indexPath.row)
            }
            if indexPath.section == 2 {
                managerObjectContext!.deleteObject(bookkeeping[indexPath.row] )
                bookkeeping.removeAtIndex(indexPath.row)
            }
            do {
                try managerObjectContext!.save()
            } catch {
                print(error)
            }
        default:
            return
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
            let movedObject = self.leadership[sourceIndexPath.row]
            leadership.removeAtIndex(sourceIndexPath.row)
            leadership.insert(movedObject, atIndex: destinationIndexPath.row)
        }
        if sourceIndexPath.section == 1 && destinationIndexPath.section == 1 {
            let movedObject = self.coWorker[sourceIndexPath.row]
            coWorker.removeAtIndex(sourceIndexPath.row)
            coWorker.insert(movedObject, atIndex: destinationIndexPath.row)
        }
        if sourceIndexPath.section == 2 && destinationIndexPath.section == 2 {
            let movedObject = self.bookkeeping[sourceIndexPath.row]
            bookkeeping.removeAtIndex(sourceIndexPath.row)
            bookkeeping.insert(movedObject, atIndex: destinationIndexPath.row)
        }
        tableView.reloadData()
    }
    
}




























