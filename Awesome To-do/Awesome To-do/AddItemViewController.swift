//
//  AddItemViewController.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/15/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var titleText: UITextField!
    weak var delegate: AddItemViewControllerDelegate?
    weak var selectedTodoItem: TodoItem?
    var isEditMode: Bool = false
    
    @IBAction func addTodoItem(_ sender: Any) {
        if isEditMode {
            if let todoItem = selectedTodoItem, let text = titleText.text {
                todoItem.title = text
                delegate?.didFinishEditing(self, item: todoItem)
            }
        } else {
            if let title = titleText.text {
                let todoItem = TodoItem(title: title, isCompleted: false)
                delegate?.didFinishAdding(self, item: todoItem)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        if isEditMode {
            addButton.isEnabled = true
            addButton.title = "Edit"
            if let todoItem = selectedTodoItem {
                titleText.text = todoItem.title
            }
        } else {
            addButton.isEnabled = false
            addButton.title = "Add"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleText.becomeFirstResponder()
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleText.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
        return true
    }
}
