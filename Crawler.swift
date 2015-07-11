//
//  Crawler.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 11/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

class Crawler: IndeterminateAnimation {
    
    var backgroundLayer = CAShapeLayer()
    var starLayer = CAShapeLayer()
    var backgroundColor: NSColor = NSColor(calibratedWhite: 0, alpha: 0.39)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        makeLayer()
    }
    
    func makeLayer() {
        let rect = self.bounds
        let insetRect = NSInsetRect(rect, 20, 20)

        self.layer?.borderColor = NSColor.blackColor().CGColor
        self.layer?.borderWidth = 1
        
        /// Add background layer
        do_ {
            backgroundLayer.bounds = insetRect
            backgroundLayer.borderWidth = 3
            backgroundLayer.position = insetRect.mid
            backgroundLayer.borderColor = NSColor.blackColor().CGColor
            backgroundLayer.backgroundColor = NSColor.grayColor().CGColor
            backgroundLayer.cornerRadius = NSWidth(insetRect) / 2
            self.layer?.addSublayer(backgroundLayer)
        }
        
        do_ {
            starLayer.backgroundColor = NSColor.lightGrayColor().CGColor
            starLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            starLayer.cornerRadius = 10
            starLayer.position = CGPoint(x: rect.midX, y: rect.midY + insetRect.height / 2)
            self.layer?.addSublayer(starLayer)
            
            var arcPath = NSBezierPath()
            arcPath.appendBezierPathWithArcWithCenter(insetRect.mid, radius: insetRect.width / 2, startAngle: 90, endAngle: -360 + 90, clockwise: true)

            var rotationAnimation = CAKeyframeAnimation(keyPath: "position")
            rotationAnimation.path = arcPath.CGPath
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rotationAnimation.removedOnCompletion = false
            rotationAnimation.duration = 2
            rotationAnimation.repeatCount = Float.infinity
            starLayer.addAnimation(rotationAnimation, forKey: "rotate")
        }
    }
}