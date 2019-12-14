//
//  MockToDoItemDataSource.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/14/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation

class MockTodoItemDataSource: TodoItemDataSourceProtocol {
    func getTodoItemList() -> [TodoItem] {
        let todoItems = [
            TodoItem(title: "Learn Swift", isCompleted: false),
            TodoItem(title: "Learn Cocoa Touch", isCompleted: false),
            TodoItem(title: "Learn MVC", isCompleted: true)
        ]
        
        return todoItems
    }
}
