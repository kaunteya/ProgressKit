//
//  WhatsAppCircular.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

private let duration = 1.5
private let strokeRange = (start: 0.0, end: 0.8)
private let defaultStrokeColor = NSColor.whiteColor()
private let defaultBackgroundColor = NSColor(calibratedWhite: 0.07, alpha: 0.7)
@IBDesignable
class CircularSnail: IndeterminateAnimation {

    @IBInspectable var lineWidth: CGFloat = -1 {
        didSet {
            progressLayer.lineWidth = lineWidth
        }
    }
    @IBInspectable var color: NSColor = NSColor.whiteColor() {
        didSet {
            progressLayer.strokeColor = color.CGColor
        }
    }
    
    @IBInspectable var backgroundColor: NSColor = NSColor(calibratedWhite: 0.07, alpha: 0.7) {
        didSet {
            backgroundLayer.backgroundColor = backgroundColor.CGColor
        }
    }

    //MARK: Shape Layer
    var backgroundLayer = CAShapeLayer()

    var progressLayer: CAShapeLayer = {
        var tempLayer = CAShapeLayer()
        tempLayer.strokeColor = defaultStrokeColor.CGColor
        tempLayer.strokeEnd = CGFloat(strokeRange.end)
        tempLayer.lineCap = kCALineCapRound
        tempLayer.fillColor = NSColor.clearColor().CGColor
        return tempLayer
    }()

    //MARK: Animation Declaration
    var animationGroup: CAAnimationGroup = {
        var tempGroup = CAAnimationGroup()
        tempGroup.repeatCount = 1
        tempGroup.duration = duration
        return tempGroup
    }()
    
    var strokeStartAnimation: CABasicAnimation!
    var strokeEndAnimation: CABasicAnimation!
    func makeStrokeAnimations() {
        func makeAnimation(keyPath: String) -> CABasicAnimation {
            var tempAnimation = CABasicAnimation(keyPath: keyPath)
            tempAnimation.repeatCount = 1
            tempAnimation.speed = 2.0
            tempAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            tempAnimation.fromValue = strokeRange.start
            tempAnimation.toValue =  strokeRange.end
            tempAnimation.duration = duration
            
            return tempAnimation
        }
        strokeEndAnimation = makeAnimation("strokeEnd")
        strokeStartAnimation = makeAnimation("strokeStart")
        strokeStartAnimation.beginTime = duration / 2
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation, ]
        animationGroup.delegate = self
    }
    
    var rotationAnimation: CABasicAnimation = {
        var tempRotation = CABasicAnimation(keyPath: "transform.rotation")
        tempRotation.repeatCount = Float.infinity
        tempRotation.fromValue = 0
        tempRotation.toValue = 1
        tempRotation.cumulative = true
        tempRotation.duration = duration / 2
        return tempRotation
        }()

    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        backgroundLayer.cornerRadius = rect.midX
        backgroundLayer.frame = rect
        backgroundLayer.backgroundColor = backgroundColor.CGColor
        self.layer?.addSublayer(backgroundLayer)
        
        // Progress Layer
        let radius = (rect.width / 2) * 0.75
        progressLayer.frame =  rect
        progressLayer.lineWidth = lineWidth == -1 ? radius / 10: lineWidth
        var arcPath = NSBezierPath()
        arcPath.appendBezierPathWithArcWithCenter(rect.mid, radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
        progressLayer.path = arcPath.CGPath
        backgroundLayer.addSublayer(progressLayer)
    }
    
    
    //MARK: Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeStrokeAnimations()
        makeLayers()
    }

    var currentRotation = 0.0
    let π2 = M_PI * 2
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if !animate { return }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        currentRotation += strokeRange.end * π2
        currentRotation %= π2
        progressLayer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat( currentRotation)))
        CATransaction.commit()
        progressLayer.addAnimation(animationGroup, forKey: "strokeEnd")
    }
    
    override func startAnimation() {
        progressLayer.addAnimation(animationGroup, forKey: "strokeEnd")
        backgroundLayer.addAnimation(rotationAnimation, forKey: rotationAnimation.keyPath)
    }
    override func stopAnimation() {
        backgroundLayer.removeAllAnimations()
        progressLayer.removeAllAnimations()
    }
}
