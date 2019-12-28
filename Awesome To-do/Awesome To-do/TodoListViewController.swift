//
//  ViewController.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/13/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var todos: [TodoItemData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    private func refresh() {
        do {
            todos = try context.fetch(TodoItemData.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let detailTodoItemController = segue.destination as? DetailTodoItemController {
                detailTodoItemController.delegate = self
            }
        } else if segue.identifier == "EditItemSegue" {
            if let detailTodoItemController = segue.destination as? DetailTodoItemController {
                detailTodoItemController.delegate = self
                detailTodoItemController.isEditMode = true
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let todoItem = self.todos[indexPath.row]
                    detailTodoItemController.selectedTodoItem = todoItem
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let todoItem = todos[indexPath.row]
        updateText(cell, todoItem)
        updateCheckmark(cell, todoItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todos[indexPath.row]
        todoItem.toggleCompletedStatus()
        appDelegate.saveContext()
        if let cell = tableView.cellForRow(at: indexPath) {
            updateCheckmark(cell, todoItem)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func updateCheckmark(_ cell: UITableViewCell, _ todoItem: TodoItemData) {
        guard let todoItemCell = cell as? TodoItemTableViewCell else {
            return
        }
        
        if todoItem.isCompleted {
            todoItemCell.checkmarkLabel.text = "✅"
        } else {
            todoItemCell.checkmarkLabel.text = ""
       }
    }
    
    fileprivate func updateText(_ cell: UITableViewCell, _ todoItem: TodoItemData) {
        if let todoCell = cell as? TodoItemTableViewCell {
            todoCell.titleLabel.text = todoItem.title
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let itemToRemove = todos[indexPath.row]
        appDelegate.persistentContainer.viewContext.delete(itemToRemove);
        appDelegate.saveContext()
        refresh()
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

extension TodoListViewController: DetailTodoItemControllerDelegate {
    func didFinishAdding(_ controller: DetailTodoItemController, newTitle: String) {
        let newTodo = TodoItemData(entity: TodoItemData.entity(), insertInto: context)
        newTodo.title = newTitle
        newTodo.isCompleted = false
        appDelegate.saveContext()
        refresh()
        
        let newRow = todos.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func didFinishEditing(_ controller: DetailTodoItemController, item: TodoItemData, newTitle: String) {
        if let index = todos.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                todos[index].title = newTitle
                updateText(cell, item)
                appDelegate.saveContext()
            }
        }
    }
}

