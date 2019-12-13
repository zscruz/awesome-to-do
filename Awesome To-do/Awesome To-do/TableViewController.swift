//
//  ViewController.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/13/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
    var todoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.todoItems = [
            TodoItem(title: "Learn Swift", isCompleted: false),
            TodoItem(title: "Learn Cocoa Touch", isCompleted: false),
            TodoItem(title: "Learn MVC", isCompleted: true)
        ]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let todoItem = todoItems[indexPath.row]
        cell.textLabel?.text = todoItem.title
        updateCheckmark(todoItem, cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItem = todoItems[indexPath.row]
        todoItem.isCompleted = !todoItem.isCompleted
        if let cell = tableView.cellForRow(at: indexPath) {
            updateCheckmark(todoItem, cell)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func updateCheckmark(_ todoItem: TodoItem, _ cell: UITableViewCell) {
        if todoItem.isCompleted {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}

