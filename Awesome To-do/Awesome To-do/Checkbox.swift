//
//  Checkbox.swift
//  Awesome To-do
//
//  Created by Zachary Cruz on 1/2/20.
//  Copyright © 2020 zscruz. All rights reserved.
//

import Foundation
import UIKit

class Checkbox: UIControl {

    public var checkboxBackgroundColor: UIColor = .clear
    public var checkboxFilledColor: UIColor = .green
    public var borderWidth: CGFloat = 2
    public var isChecked: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
        
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        isChecked = !isChecked
        print("hit")
        
    }
    
    override func draw(_ rect: CGRect) {
        let adjustedRect = CGRect(x: borderWidth / 2,
        y: borderWidth / 2,
        width: rect.width - borderWidth,
        height: rect.height - borderWidth)
        
        let ovalPath = UIBezierPath(ovalIn: adjustedRect)

        ovalPath.lineWidth = borderWidth
        if isChecked {
            checkboxFilledColor.setFill()
        } else {
            checkboxBackgroundColor.setFill()
        }
        
        ovalPath.stroke()
        ovalPath.fill()
    }
}
