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
    
    private var todos: [TodoItem] = []
    
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
            todos = try context.fetch(TodoItem.fetchRequest())
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TodoItemTableViewCell
        let todoItem = todos[indexPath.row]
        updateCheckmark(cell, todoItem)
        updateText(cell, todoItem)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todos[indexPath.row]
        todoItem.toggleCompletedStatus()
        appDelegate.saveContext()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func updateCheckmark(_ cell: UITableViewCell, _ todoItem: TodoItem) {
        guard let todoItemCell = cell as? TodoItemTableViewCell else {
            return
        }

        if todoItem.isCompleted {
            todoItemCell.checkboxControl.isChecked = true
        } else {
            todoItemCell.checkboxControl.isChecked = false
        }
    }
    
    fileprivate func updateText(_ cell: UITableViewCell, _ todoItem: TodoItem) {
        if let todoCell = cell as? TodoItemTableViewCell {
            todoCell.titleLabel.text = todoItem.title
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "This item will be deleted permanently.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (UIAlertAction) in
                let itemToRemove = self.todos[indexPath.row]
                self.appDelegate.persistentContainer.viewContext.delete(itemToRemove);
                self.appDelegate.saveContext()
                self.refresh()
               let indexPaths = [indexPath]
               tableView.deleteRows(at: indexPaths, with: .automatic)
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
}

extension TodoListViewController: DetailTodoItemControllerDelegate {
    func didFinishAdding(_ controller: DetailTodoItemController, newTitle: String) {
        let newTodo = TodoItem(entity: TodoItem.entity(), insertInto: context)
        newTodo.title = newTitle
        newTodo.isCompleted = false
        appDelegate.saveContext()
        refresh()
        
        let newRow = todos.count - 1
        let indexPath = IndexPath(row: newRow, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func didFinishEditing(_ controller: DetailTodoItemController, item: TodoItem, newTitle: String) {
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

extension TodoListViewController: TodoItemTableCellDelegate {
    func todoItemTableCell(_ todoItemTableCell: TodoItemTableViewCell, checkboxTapped: Bool) {
        let indexPath = tableView.indexPath(for: todoItemTableCell)
        if let index = indexPath?.row {
            todos[index].isCompleted = checkboxTapped
            appDelegate.saveContext()
            refresh()
        }
    }
}

