//
//  Corporate.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import Foundation
import CoreData


class Corporate: NSManagedObject {

    @NSManaged var fullName: String?
    @NSManaged var salary: NSNumber?
}
