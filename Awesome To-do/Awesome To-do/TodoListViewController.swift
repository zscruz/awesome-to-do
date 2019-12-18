//
//  ViewController.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/13/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {
    var todoList: TodoList = TodoList()
    let data = TodoItemDataSource()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.todoList = self.data.getTodoItemList()
        navigationController?.navigationBar.prefersLargeTitles = true
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
                    let todoItem = self.todoList.todoItems[indexPath.row]
                    detailTodoItemController.selectedTodoItem = todoItem
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let todoItem = todoList.todoItems[indexPath.row]
        updateText(cell, todoItem)
        updateCheckmark(cell, todoItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todoList.todoItems[indexPath.row]
        todoItem.toggleCompletedStatus()
        if let cell = tableView.cellForRow(at: indexPath) {
            updateCheckmark(cell, todoItem)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func updateCheckmark(_ cell: UITableViewCell, _ todoItem: TodoItem) {
        guard let todoItemCell = cell as? TodoItemTableViewCell else {
            return
        }
        
        if todoItem.isCompleted {
            todoItemCell.checkmarkLabel.text = "✅"
        } else {
            todoItemCell.checkmarkLabel.text = ""
       }
    }
    
    fileprivate func updateText(_ cell: UITableViewCell, _ todoItem: TodoItem) {
        if let todoCell = cell as? TodoItemTableViewCell {
            todoCell.titleLabel.text = todoItem.title
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todoItems.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

extension TodoListViewController: DetailTodoItemControllerDelegate {
    func didFinishAdding(_ controller: DetailTodoItemController, item: TodoItem) {
        self.data.addTodoItem(todoItemToAdd: item)
        self.todoList.addTodoItem(todoItemToAdd: item)
        let newRow = todoList.todoItems.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic) //-> This call causes the app to crash. Need to figure out why.
    }
    
    func didFinishEditing(_ controller: DetailTodoItemController, item: TodoItem) {
        if let index = todoList.todoItems.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                updateText(cell, item)
            }
        }
    }
}

