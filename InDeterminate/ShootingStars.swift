//
//  ShootingStars.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 09/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class ShootingStars: NSView {
    
    @IBInspectable var backgroundColor: NSColor = NSColor( red: 0.2026, green: 0.7113, blue: 0.9, alpha: 1.0 ) {
        didSet {
            backgroundLayer.backgroundColor = backgroundColor.CGColor
        }
    }
    
    @IBInspectable var starColor: NSColor = NSColor.whiteColor() {
        didSet {
            starLayer1.backgroundColor = starColor.CGColor
            starLayer2.backgroundColor = starColor.CGColor
        }
    }
    
    var backgroundLayer = CAShapeLayer()
    var starLayer1 = CAShapeLayer()
    var starLayer2 = CAShapeLayer()
    var animation = CABasicAnimation(keyPath: "position.x")
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }
    
    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        let dimension = rect.height
        let starWidth = dimension * 1.5
        
        /// Add background layer
        backgroundLayer.frame = rect
        backgroundLayer.backgroundColor = backgroundColor.CGColor
        self.layer?.addSublayer(backgroundLayer)
        
        /// Add Stars
        do_ {
            starLayer1.position = CGPoint(x: dimension / 2, y: dimension / 2)
            starLayer1.bounds.size = CGSize(width: starWidth, height: dimension)
            starLayer1.backgroundColor = starColor.CGColor
            backgroundLayer.addSublayer(starLayer1)
            
            starLayer2.position = CGPoint(x: rect.midX, y: dimension / 2)
            starLayer2.bounds.size = CGSize(width: starWidth, height: dimension)
            starLayer2.backgroundColor = starColor.CGColor
            backgroundLayer.addSublayer(starLayer2)
        }
        
        /// Add default animation
        do_ {
            animation.fromValue = -dimension
            animation.toValue = rect.width * 0.9
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            animation.removedOnCompletion = false
            animation.repeatCount = Float.infinity
        }
        
        /** Temp animation will be removed after first animation
            After finishing it will invoke animationDidStop and starLayer2 is also given default animation.
        The purpose of temp animation is to generate an temporary offset
        */
        var tempAnimation = CABasicAnimation(keyPath: "position.x")
        tempAnimation.fromValue = rect.midX
        tempAnimation.toValue = rect.width
        tempAnimation.delegate = self
        tempAnimation.duration = 0.5
        tempAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        /// Add animations
        starLayer1.addAnimation(animation, forKey: "default")
        starLayer2.addAnimation(tempAnimation, forKey: "tempAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        starLayer2.addAnimation(animation, forKey: "p2")
    }
}