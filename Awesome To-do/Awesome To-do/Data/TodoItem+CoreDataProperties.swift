//
//  TodoItem+CoreDataProperties.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 1/20/20.
//  Copyright © 2020 zscruz. All rights reserved.
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
    @NSManaged public var owner: TodoList?

}
