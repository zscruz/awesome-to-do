//
//  AddItemViewController.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/15/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit

class DetailTodoItemController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var titleText: UITextField!
    
    weak var delegate: DetailTodoItemControllerDelegate?
    weak var selectedTodoItem: TodoItem?
    
    var isEditMode: Bool = false
    
    @IBAction func addTodoItem(_ sender: Any) {
        if isEditMode {
           editItem()
        } else {
           addTodoItem()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func editItem() {
        if let todoItem = selectedTodoItem, let text = titleText.text {
            delegate?.didFinishEditing(self, item: todoItem, newTitle: text)
        }
    }
    
    private func addTodoItem() {
        if let title = titleText.text {
           delegate?.didFinishAdding(self, newTitle: title)
       }
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

extension DetailTodoItemController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editItem()
        titleText.resignFirstResponder()
        navigationController?.popViewController(animated: true)
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
