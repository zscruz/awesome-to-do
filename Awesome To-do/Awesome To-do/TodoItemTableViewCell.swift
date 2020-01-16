//
//  TodoItemTableViewCell.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 12/18/19.
//  Copyright © 2019 zscruz. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxControl: Checkbox!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: TodoItemTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkboxControl.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        self.delegate?.todoItemTableCell(self, checkboxTapped: sender.isChecked)
    }

}
