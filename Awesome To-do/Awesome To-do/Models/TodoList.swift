//
//  TodoList.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/17/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation
class TodoList {
    var todoItems: [TodoItem] = []
    
    init() {
        todoItems = []
    }
    
    init(todoItems: [TodoItem]) {
        self.todoItems = todoItems
    }
    
    func addTodoItem(todoItemToAdd: TodoItem) {
        todoItems.append(todoItemToAdd)
    }
    
    func removeTodoItem(todoItemToRemove: TodoItem) {
        if let index = todoItems.firstIndex(of: todoItemToRemove) {
            todoItems.remove(at: index)
        }
    }
}
