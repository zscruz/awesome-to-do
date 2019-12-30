//
//  TodoItem+CoreDataProperties.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/30/19.
//  Copyright © 2019 zscruz. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?

}
