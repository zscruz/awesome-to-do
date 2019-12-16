//
//  TodoItem.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/13/19.
//  Copyright © 2019 zscruz. All rights reserved.
//
import Foundation

class TodoItem: NSObject {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func toggleCompletedStatus() {
        self.isCompleted = !self.isCompleted
    }
}
