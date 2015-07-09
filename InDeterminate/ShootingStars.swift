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

        func addBackgroundLayer() {
            backgroundLayer.frame = rect
            backgroundLayer.backgroundColor = backgroundColor.CGColor
            self.layer?.addSublayer(backgroundLayer)
        }
        
        func makeStar1() {
            starLayer1.position = CGPoint(x: dimension / 2, y: dimension / 2)
            starLayer1.bounds.size = CGSize(width: dimension * 1.5, height: dimension)
            starLayer1.backgroundColor = starColor.CGColor
            backgroundLayer.addSublayer(starLayer1)
        }

        func makeStar2() {
            starLayer2.position = CGPoint(x: rect.width / 2, y: dimension / 2)
            starLayer2.bounds.size = CGSize(width: dimension * 1.5, height: dimension)
            starLayer2.backgroundColor = starColor.CGColor
            backgroundLayer.addSublayer(starLayer2)
        }
        
        func makeAnimation() {
            animation.fromValue = -dimension
            animation.toValue = rect.width * 0.9
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            animation.removedOnCompletion = false
            animation.repeatCount = Float.infinity
        }
        
        addBackgroundLayer()
        makeStar1()
        makeStar2()
        makeAnimation()
        
        var tempMiddleAnimation = CABasicAnimation(keyPath: "position.x")
        tempMiddleAnimation.fromValue = 50
        tempMiddleAnimation.toValue = rect.width
        tempMiddleAnimation.delegate = self
        tempMiddleAnimation.duration = 0.5
        tempMiddleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        starLayer1.addAnimation(animation, forKey: "p1")
        starLayer2.addAnimation(tempMiddleAnimation, forKey: "tempAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let tempAnimation = anim as? CABasicAnimation {
            // if keypath == "temp" then remove
            starLayer2.addAnimation(animation, forKey: "p2")
        }
    }
}