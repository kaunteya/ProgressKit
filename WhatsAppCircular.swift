//
//  WhatsAppCircular.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class WhatsAppCircular: NSView {
    var color: NSColor = NSColor.redColor()
    var backgroundColor: NSColor = NSColor.purpleColor().colorWithAlphaComponent(0.5)

    //MARK: Shape Layer
    var backgroundLayer = CAShapeLayer()
    var progressLayer: CAShapeLayer = {
        var tempLayer = CAShapeLayer()
        tempLayer.strokeColor = NSColor.redColor().CGColor
        tempLayer.lineWidth = 5
        tempLayer.strokeEnd = 0
        tempLayer.fillColor = NSColor.clearColor().CGColor
        return tempLayer
    }()

    //MARK: Animation Declaration
    var strokeEndAnimation: CABasicAnimation = {
        var tempAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tempAnimation.fromValue = 0
        tempAnimation.toValue =  1

        tempAnimation.duration = 5
        tempAnimation.repeatCount = 1
        return tempAnimation
        }()

    var strokeStartAnimation: CABasicAnimation = {
        var tempAnimation = CABasicAnimation(keyPath: "strokeStart")
        tempAnimation.fromValue = 0
        tempAnimation.toValue =  1
        
        tempAnimation.duration = 5
        tempAnimation.repeatCount = 1
        return tempAnimation
        }()
    
    var rotationAnimation: CABasicAnimation = {
        var tempRotation = CABasicAnimation(keyPath: "transform.rotation")
        let rduration = Double(2)
        tempRotation.toValue = 10
        tempRotation.duration = rduration
        tempRotation.repeatCount = 1
        return tempRotation
        }()
    
    //MARK: Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }

    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        addBackgroundLayer(rect)
        addProgressLayer(rect)
    }

    func addBackgroundLayer(rect: NSRect) {
        let radius = NSWidth(rect) * 0.1
        backgroundLayer.frame = rect
        backgroundLayer.fillColor = backgroundColor.CGColor
        var backgroundPath = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
        backgroundLayer.path = backgroundPath.CGPath
        self.layer?.addSublayer(backgroundLayer)
    }

    func addProgressLayer(rect: NSRect) {
        let radius = (rect.width / 2) * 0.75
        progressLayer.frame =  rect
        var arcPath = NSBezierPath()//roundedRect: NSInsetRect(rect, 10, 30), xRadius: 10, yRadius: 18)
        
        arcPath.appendBezierPathWithArcWithCenter(rect.center(), radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
        progressLayer.path = arcPath.CGPath

        self.layer?.addSublayer(progressLayer)
    }
    
    //MARK: Animation Handlers
    var currentRotation = CGFloat(0)
    func startAnimation(testVal: CGFloat) {
        strokeStartAnimation.delegate = self
        strokeEndAnimation.delegate = self
//        progressLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")

//        progressLayer.strokeStart = 0.8
//        progressLayer.strokeEnd = 0.8
//
//        progressLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")

//        progressLayer.addAnimation(rotationAnimation, forKey: "transform.rotation")

        var animationGroup = CAAnimationGroup()
        animationGroup.duration = 4

        strokeEndAnimation.beginTime = 0
        strokeEndAnimation.duration = 4
        strokeEndAnimation.speed = 2.0
        
        strokeStartAnimation.beginTime = 1.5
        strokeStartAnimation.speed = 2.0
        strokeStartAnimation.duration = 4
        
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation,]
        animationGroup.repeatCount = 1
        animationGroup.delegate = self
        progressLayer.addAnimation(animationGroup, forKey: "strokeStart")

    }
    
    func stopAnimation() {
        progressLayer.removeAllAnimations()
    }
    
    override func animationDidStart(anim: CAAnimation!) {
        println("Animations started")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        println("Animation ends \(progressLayer.animationKeys())")

//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        currentRotation += 0.3
        //        progressLayer.setAffineTransform(CGAffineTransformMakeRotation(currentRotation))
        //        CATransaction.commit()
        
        if let key = (anim as? CABasicAnimation)?.keyPath {
            if key == "strokeEnd" {
                println("Animating for start")
                progressLayer.strokeStart = 0.8
                progressLayer.strokeEnd = 0.8
                progressLayer.addAnimation(strokeStartAnimation, forKey: "strokeStart")
            } else if key == "strokeStart" {
                println("Animating for End")
                progressLayer.strokeStart = 0
                progressLayer.strokeEnd = 0
                progressLayer.addAnimation(strokeEndAnimation, forKey: "strokeEnd")
            }
        }

    }
}

func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees / CGFloat(180.0 * M_PI)
}


func radiansToDegrees( radians:Double ) -> Double {
     return radians  *  180.0 / M_PI
}

