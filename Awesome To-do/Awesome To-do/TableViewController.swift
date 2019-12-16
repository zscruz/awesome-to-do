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
    
    @IBAction func addItem(_ sender: Any) {
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let mockData = MockTodoItemDataSource()
        self.todoItems = mockData.getTodoItemList()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? AddItemViewController {
                addItemViewController.delegate = self
            }
        }
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
        todoItem.toggleCompletedStatus()
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

extension TableViewController: AddItemViewControllerDelegate {
    func didCancel(_ controller: AddItemViewController) {
    }
    
    func didFinishAdding(_ controller: AddItemViewController, item: TodoItem) {
        self.todoItems.append(item)
//        let newRow = todoItems.count
//        let indexPath = IndexPath(row: newRow, section: 0)
//        let indexPaths = [indexPath]
//        tableView.insertRows(at: indexPaths, with: .automatic) -> This call causes the app to crash. Need to figure out why.
        tableView.reloadData()
        
    }
}

