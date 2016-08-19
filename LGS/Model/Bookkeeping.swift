//
//  Bookkeeping.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import Foundation
import CoreData


class Bookkeeping: Corporate {

    @NSManaged var bookkeepingType: NSNumber?
    @NSManaged var lunchTime: String?
    @NSManaged var seatNumber: NSNumber?
}
