//
//  TodoList+CoreDataProperties.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 1/20/20.
//  Copyright © 2020 zscruz. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var title: String?
    @NSManaged public var todoItems: NSSet?

}

// MARK: Generated accessors for todoItems
extension TodoList {

    @objc(addTodoItemsObject:)
    @NSManaged public func addToTodoItems(_ value: TodoItem)

    @objc(removeTodoItemsObject:)
    @NSManaged public func removeFromTodoItems(_ value: TodoItem)

    @objc(addTodoItems:)
    @NSManaged public func addToTodoItems(_ values: NSSet)

    @objc(removeTodoItems:)
    @NSManaged public func removeFromTodoItems(_ values: NSSet)

}
