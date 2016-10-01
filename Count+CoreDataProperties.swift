//
//  Count+CoreDataProperties.swift
//  Attendees
//
//  Created by Manuel Reinhard on 01.10.16.
//  Copyright © 2016 Manuel Reinhard. All rights reserved.
//

import Foundation
import CoreData


extension Count {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Count> {
        return NSFetchRequest<Count>(entityName: "Count");
    }

    @NSManaged public var count: Int16
    @NSManaged public var date: NSDate?
    @NSManaged public var title: String?

}
