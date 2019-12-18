//
//  TodoItemDataSource.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/18/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation
import CoreData

class TodoItemDataSource: TodoItemDataSourceProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
                print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func getTodoItemList() -> [TodoItemData] {
        let context = persistentContainer.viewContext
        var todos = [TodoItemData]()
        do {
           todos = try context.fetch(TodoItemData.fetchRequest())
        } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return todos
    }
    
    func addTodoItem(todoItemToAdd: TodoItem) -> TodoItemData {
        let data = TodoItemData(entity: TodoItemData.entity(), insertInto: self.persistentContainer.viewContext)
        data.title = todoItemToAdd.title
        data.isCompleted = todoItemToAdd.isCompleted
        self.saveContext()
        return data
    }
    
    func removeTodoItem(todoItemToRemove: TodoItemData) {
        persistentContainer.viewContext.delete(todoItemToRemove)
        self.saveContext()
    }
    
//    func updateTitle(item: TodoItemData, newTitle: String) {
//    }
}
