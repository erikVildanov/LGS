//
//  CorporateService.swift
//  LGS
//
//  Created by Эрик Вильданов on 19.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import CoreData

class CorporateService {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func createNewLeadership(fullName: String, salary: NSNumber, businessHours: String ) -> Leadership {
        
        let newLeadership = NSEntityDescription.insertNewObjectForEntityForName("Leadership", inManagedObjectContext: context) as! Leadership
        
        newLeadership.fullName = fullName
        newLeadership.salary = salary
        newLeadership.businessHours = businessHours
        
        return newLeadership
    }
    
    func createNewCoWorker(fullName: String, salary: NSNumber, lunchTime: String, seatNumber: NSNumber) -> CoWorker {
        
        let newCoWorker = NSEntityDescription.insertNewObjectForEntityForName("CoWorker", inManagedObjectContext: context) as! CoWorker
        
        newCoWorker.fullName = fullName
        newCoWorker.salary = salary
        newCoWorker.lunchTime = lunchTime
        newCoWorker.seatNumber = seatNumber
        
        return newCoWorker
    }
    
    func createNewBookkeeping(fullName: String, salary: NSNumber, businessHours: String, lunchTime: String, seatNumber: NSNumber, bookkeepingType: NSNumber) -> Bookkeeping {
        
        let newBookkeeping = NSEntityDescription.insertNewObjectForEntityForName("Bookkeeping", inManagedObjectContext: context) as! Bookkeeping
        
        newBookkeeping.fullName = fullName
        newBookkeeping.salary = salary
        newBookkeeping.lunchTime = lunchTime
        newBookkeeping.seatNumber = seatNumber
        newBookkeeping.bookkeepingType = bookkeepingType
        
        return newBookkeeping
    }
    
    func getByIdLeadership(id: NSManagedObjectID) -> Leadership? {
        return context.objectWithID(id) as? Leadership
    }
    
    func getByIdCoWorker(id: NSManagedObjectID) -> CoWorker? {
        return context.objectWithID(id) as? CoWorker
    }
    
    func getByIdBookkeeping(id: NSManagedObjectID) -> Bookkeeping? {
        return context.objectWithID(id) as? Bookkeeping
    }
    
    func getAllLeadership() -> [Leadership]{
        return getLeadership(withPredicate: NSPredicate(value:true))
    }
    
    func getAllCoWorker() -> [CoWorker]{
        return getCoWorker(withPredicate: NSPredicate(value:true))
    }
    
    func getAllBookkeeping() -> [Bookkeeping]{
        return getBookkeeping(withPredicate: NSPredicate(value:true))
    }
    
    func getLeadership(withPredicate queryPredicate: NSPredicate) -> [Leadership]{
        let fetchRequest = NSFetchRequest(entityName: "Leadership")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.executeFetchRequest(fetchRequest)
            return response as! [Leadership]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Leadership]()
        }
    }
    func getCoWorker(withPredicate queryPredicate: NSPredicate) -> [CoWorker]{
        let fetchRequest = NSFetchRequest(entityName: "CoWorker")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.executeFetchRequest(fetchRequest)
            return response as! [CoWorker]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [CoWorker]()
        }
    }
    func getBookkeeping(withPredicate queryPredicate: NSPredicate) -> [Bookkeeping]{
        let fetchRequest = NSFetchRequest(entityName: "Bookkeeping")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.executeFetchRequest(fetchRequest)
            return response as! [Bookkeeping]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Bookkeeping]()
        }
    }
    
    func updateLeadership(updatedLeadership: Leadership){
        if let leadership = getByIdLeadership(updatedLeadership.objectID){
            leadership.fullName = updatedLeadership.fullName
            leadership.salary = updatedLeadership.salary
            leadership.businessHours = updatedLeadership.businessHours
        }
    }
    func updateCoWorker(updatedCoWorker: CoWorker){
        if let CoWorker = getByIdCoWorker(updatedCoWorker.objectID){
            CoWorker.fullName = updatedCoWorker.fullName
            CoWorker.salary = updatedCoWorker.salary
            CoWorker.lunchTime = updatedCoWorker.lunchTime
            CoWorker.seatNumber = updatedCoWorker.seatNumber
        }
    }
    func updateBookkeeping(updatedBookkeeping: Bookkeeping){
        if let bookkeeping = getByIdBookkeeping(updatedBookkeeping.objectID){
            bookkeeping.fullName = updatedBookkeeping.fullName
            bookkeeping.salary = updatedBookkeeping.salary
            bookkeeping.lunchTime = updatedBookkeeping.lunchTime
            bookkeeping.seatNumber = updatedBookkeeping.seatNumber
            bookkeeping.bookkeepingType = updatedBookkeeping.bookkeepingType
        }
    }
    
    func deleteLeadership(id: NSManagedObjectID){
        if let personToDelete = getByIdLeadership(id){
            context.deleteObject(personToDelete)
        }
    }
    func deleteCoWorker(id: NSManagedObjectID){
        if let personToDelete = getByIdCoWorker(id){
            context.deleteObject(personToDelete)
        }
    }
    func deleteBookkeeping(id: NSManagedObjectID){
        if let personToDelete = getByIdBookkeeping(id){
            context.deleteObject(personToDelete)
        }
    }
    
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
}










































