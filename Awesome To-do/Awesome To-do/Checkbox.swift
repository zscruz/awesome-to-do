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

    public var borderColor: UIColor = .gray
    public var uncheckedFill: UIColor = .clear
    public var checkedFill: UIColor = .gray
    public var tickColor: UIColor = .white
    public var borderWidth: CGFloat = 2
    public var checkmarkSize: CGFloat = 0.5
    
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    
    public var isChecked: Bool = false {
        didSet { setNeedsDisplay() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
        setupFeedback()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFeedback()
        setupGesture()
        setupFeedback()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupFeedback() {
        feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator?.prepare()
    }
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        isChecked = !isChecked
        sendActions(for: .valueChanged)
        
        feedbackGenerator?.impactOccurred()
        feedbackGenerator?.prepare()
    }
    
    override func draw(_ rect: CGRect) {
        let adjustedRect = CGRect(
            x: borderWidth / 2,
            y: borderWidth / 2,
            width: rect.width - borderWidth,
            height: rect.height - borderWidth)
        
        let ovalPath = UIBezierPath(ovalIn: adjustedRect)
        ovalPath.lineWidth = borderWidth
        
        if isChecked {
            checkedFill.setFill()
            ovalPath.fill()
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: adjustedRect.minX + 0.25 * adjustedRect.width, y: adjustedRect.minY + 0.4 * adjustedRect.height))
            bezierPath.addLine(to: CGPoint(x: adjustedRect.minX + 0.4 * adjustedRect.width, y: adjustedRect.minY + 0.7 * adjustedRect.height))
            bezierPath.addLine(to: CGPoint(x: adjustedRect.minX + 0.75 * adjustedRect.width, y: adjustedRect.minY + 0.2 * rect.height))
                bezierPath.lineWidth = checkmarkSize * 5
            
            tickColor.setStroke()
            bezierPath.stroke()
        } else {
            uncheckedFill.setFill()
            ovalPath.fill()
        }
        
        borderColor.setStroke()
        ovalPath.stroke()
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let frame = self.bounds
        let increasedTouchRadius: CGFloat = 5
        let hitEdgeInsets = UIEdgeInsets(top: -increasedTouchRadius, left: -increasedTouchRadius, bottom: -increasedTouchRadius, right: -increasedTouchRadius)
        let hitFrame = frame.inset(by: hitEdgeInsets)
        return hitFrame.contains(point)
    }
}
