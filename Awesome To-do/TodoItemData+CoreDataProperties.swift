//
//  TodoItemData+CoreDataProperties.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/18/19.
//  Copyright © 2019 zscruz. All rights reserved.
//
//

import Foundation
import CoreData

// Auto-generated. Don't add code to this.
extension TodoItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItemData> {
        return NSFetchRequest<TodoItemData>(entityName: "TodoItemData")
    }

    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool

}
