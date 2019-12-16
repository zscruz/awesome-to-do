//
//  AddItemViewControllerDelegate.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/15/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation

protocol AddItemViewControllerDelegate: class {
    func didCancel(_ controller: AddItemViewController)
    func didFinishAdding(_ controller: AddItemViewController, item: TodoItem)
}
