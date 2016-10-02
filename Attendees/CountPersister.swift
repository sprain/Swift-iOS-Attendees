//
//  DataPersister.swift
//  Attendees
//
//  Created by Manuel Reinhard on 01.10.16.
//  Copyright © 2016 Manuel Reinhard. All rights reserved.
//

import UIKit
import CoreData

class CountPersister: NSObject {

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let countFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Count.entityName)
    
    static func save(counter: Int16, title: String) {
        let count = NSEntityDescription.insertNewObject(forEntityName: Count.entityName, into: self.context) as? Count
        count?.setValue(NSDate(), forKey: "date")
        count?.setValue(title, forKey: "title")
        count?.setValue(NSNumber(value: counter), forKey: "count")
        do {try self.context.save()} catch {}
    }
    
    static func delete(count: Count) {
        self.context.delete(count)
        do {try self.context.save()} catch {}
    }
    
    static func countAll() -> Int {
        do {
            let count = try self.context.count(for: self.countFetchRequest)
            return count
        } catch {
            return 0
        }
    }
    
    static func loadAll() -> Array<Count> {
        do {
            let counts = try self.context.fetch(self.countFetchRequest) as! [Count]
            return counts
        } catch {
            return []
        }
    }
    
    static func loadExamples() -> Void {
        if (0 == self.countAll()) {
            self.save(counter: 171, title: "Goals in World Cup 2014")
            self.save(counter: 206, title: "United Nations members")
            self.save(counter: 8,   title: "Light minutes to the sun")
        }
    }
}
