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
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }
    
    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        
        backgroundLayer.frame = rect
        backgroundLayer.borderWidth = 1
        self.layer!.addSublayer(backgroundLayer)

        borderLayer.frame = NSInsetRect(rect, 3, 3)
        borderLayer.cornerRadius = borderLayer.frame.height / 2
        borderLayer.borderWidth = 2.0
        backgroundLayer.addSublayer(borderLayer)

        progressLayer.frame = NSInsetRect(borderLayer.bounds, 5, 5)
        progressLayer.frame.size.width /= 2.0
        progressLayer.cornerRadius = progressLayer.frame.height / 2
        progressLayer.backgroundColor = NSColor.purpleColor().CGColor
        borderLayer.addSublayer(progressLayer)

    }
}