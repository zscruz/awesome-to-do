//
//  TodoItemDataSourceProtocol.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/14/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import Foundation

protocol TodoItemDataSourceProtocol {
    func getTodoItemList() -> [TodoItem]
}
