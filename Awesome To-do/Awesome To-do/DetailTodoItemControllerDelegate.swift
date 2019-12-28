//
//  AddItemViewControllerDelegate.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/15/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation

protocol DetailTodoItemControllerDelegate: class {
    func didFinishAdding(_ controller: DetailTodoItemController, newTitle: String)
    func didFinishEditing(_ controller: DetailTodoItemController, item: TodoItemData, newTitle: String)
}
