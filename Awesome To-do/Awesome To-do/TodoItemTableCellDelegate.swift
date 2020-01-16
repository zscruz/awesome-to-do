//
//  TodoItemToggleDelegate.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 1/15/20.
//  Copyright © 2020 zscruz. All rights reserved.
//

import Foundation
protocol TodoItemTableCellDelegate: class {
    func todoItemTableCell(_ todoItemTableCell: TodoItemTableViewCell, checkboxTapped: Bool)
}
