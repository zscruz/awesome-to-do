//
//  TodoItem+CoreDataClass.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/30/19.
//  Copyright © 2019 zscruz. All rights reserved.
//
//

import Foundation
import CoreData


public class TodoItem: NSManagedObject {
    func toggleCompletedStatus() {
        self.isCompleted = !self.isCompleted
    }
}
