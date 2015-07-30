//
//  ProgressBar.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 31/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class ProgressBar: DeterminateAnimation {

    var backgroundLayer = CAShapeLayer()
    var borderLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    
    @IBInspectable var borderColor: NSColor = NSColor.blackColor() {
        didSet {
            borderLayer.borderColor = borderColor.CGColor
        }
    }

    @IBInspectable var progressColor: NSColor = NSColor ( red: 0.2676, green: 0.5006, blue: 0.8318, alpha: 1.0 ) {
        didSet {
            progressLayer.backgroundColor = progressColor.CGColor
        }
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }
    
    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        
        backgroundLayer.frame = rect
        self.layer!.addSublayer(backgroundLayer)

        borderLayer.frame = NSInsetRect(rect, 0, 0)
        borderLayer.cornerRadius = borderLayer.frame.height / 2
        borderLayer.borderWidth = 1.0
        backgroundLayer.addSublayer(borderLayer)

        progressLayer.frame = NSInsetRect(borderLayer.bounds, 3, 3)
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6)
        progressLayer.cornerRadius = progressLayer.frame.height / 2
        progressLayer.backgroundColor = progressColor.CGColor
        borderLayer.addSublayer(progressLayer)

    }
    
    override func updateProgress() {
        CATransaction.begin()
        if animated {
            CATransaction.setAnimationDuration(0.5)
        } else {
            CATransaction.setDisableActions(true)
        }
        let timing = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        CATransaction.setAnimationTimingFunction(timing)
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6) * progress
//        percentLabelLayer.string = "\(Int(progress * 100))%"
        CATransaction.commit()
    }
}