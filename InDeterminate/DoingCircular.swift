//
//  WhatsAppCircular.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa


private let defaultBackgroundColor = NSColor(calibratedWhite: 0.07, alpha: 0.7)
private let defaultStrokeColor = NSColor.whiteColor()

@IBDesignable
class DoingCircular: InDeterminateAnimation {

    @IBInspectable var lineWidth: CGFloat = -1 {
        didSet {
            progressLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable var color: NSColor = defaultStrokeColor {
        didSet {
            progressLayer.strokeColor = color.CGColor
        }
    }
    
    @IBInspectable var backgroundColor: NSColor = defaultBackgroundColor {
        didSet {
            backgroundLayer.fillColor = backgroundColor.CGColor
        }
    }

    let lengthRatio = (0.0, 0.8)
    let duration = 1.5
//    var animate: Bool = false {
//        didSet {
//            //MARK: Animation Handlers
//
//        }
//    }
    //MARK: Shape Layer
    var backgroundLayer: CAShapeLayer = {
        var tempLayer = CAShapeLayer()
        tempLayer.fillColor = defaultBackgroundColor.CGColor
        return tempLayer
    }()
    var rotationBaseLayer = CAShapeLayer()
    var progressLayer: CAShapeLayer = {
        var tempLayer = CAShapeLayer()
        tempLayer.strokeColor = defaultStrokeColor.CGColor
        tempLayer.strokeEnd = 0.8
        tempLayer.lineCap = kCALineCapRound
        tempLayer.fillColor = NSColor.clearColor().CGColor
        return tempLayer
    }()

    //MARK: Animation Declaration
    var animationGroup: CAAnimationGroup = {
        var tempGroup = CAAnimationGroup()
        tempGroup.repeatCount = 1
        return tempGroup
    }()
    
    var strokeEndAnimation: CABasicAnimation = {
        var tempAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tempAnimation.repeatCount = 1
        tempAnimation.speed = 2.0
        tempAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        tempAnimation.fillMode = kCAFillModeForwards // kCAFillModeBoth
        return tempAnimation
        }()

    var strokeStartAnimation: CABasicAnimation = {
        var tempAnimation = CABasicAnimation(keyPath: "strokeStart")
        tempAnimation.repeatCount = 1
        tempAnimation.speed = 2.0
        tempAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return tempAnimation
        }()
    
    
    var rotationAnimation: CABasicAnimation = {
        var tempRotation = CABasicAnimation(keyPath: "transform.rotation")
        tempRotation.repeatCount = Float.infinity
        tempRotation.fromValue = 0
        tempRotation.toValue = 1
        tempRotation.cumulative = true
        return tempRotation
        }()
    
    //MARK: Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }

    func makeLayers() {
        self.wantsLayer = true
        let rect = NSInsetRect(self.bounds, 0, 0)
        let baseLayerRotationRadius = NSWidth(rect) / 2

        backgroundLayer.frame = rect
        var backgroundPath = NSBezierPath(roundedRect: rect, xRadius: baseLayerRotationRadius, yRadius: baseLayerRotationRadius)
        backgroundLayer.path = backgroundPath.CGPath
        self.layer?.addSublayer(backgroundLayer)
        
        rotationBaseLayer.frame = rect
        rotationBaseLayer.fillColor = NSColor.clearColor().CGColor
        rotationBaseLayer.path = NSBezierPath(roundedRect: rect, xRadius: 0, yRadius: 0).CGPath
        backgroundLayer.addSublayer(rotationBaseLayer)
        
        addProgressLayer(rect)
    }


    func addProgressLayer(rect: NSRect) {
        let radius = (rect.width / 2) * 0.75
        progressLayer.frame =  rect
        progressLayer.lineWidth = lineWidth == -1 ? radius / 10: lineWidth
        var arcPath = NSBezierPath()
        arcPath.appendBezierPathWithArcWithCenter(rect.mid, radius: radius, startAngle: 0, endAngle: 360, clockwise: false)
        progressLayer.path = arcPath.CGPath

        strokeEndAnimation.fromValue = lengthRatio.0
        strokeEndAnimation.toValue =  lengthRatio.1
        strokeEndAnimation.duration = duration

        strokeStartAnimation.fromValue = lengthRatio.0
        strokeStartAnimation.toValue =  lengthRatio.1
        strokeStartAnimation.duration = duration
        strokeStartAnimation.beginTime = duration / 2

        rotationAnimation.duration = duration / 2
        
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation, ]
        animationGroup.duration = duration
        animationGroup.delegate = self
        
        rotationBaseLayer.addSublayer(progressLayer)
    }
    

    var currentRotation = CGFloat(0.0)
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if !animate { return }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        currentRotation += CGFloat(lengthRatio.1) * 360 * 0.01746
        currentRotation %= CGFloat(M_PI * 2)
        progressLayer.setAffineTransform(CGAffineTransformMakeRotation(currentRotation))
        CATransaction.commit()
        progressLayer.addAnimation(animationGroup, forKey: "strokeEnd")
    }
    
    override func startAnimation() {
        progressLayer.addAnimation(animationGroup, forKey: "strokeEnd")
        rotationBaseLayer.addAnimation(rotationAnimation, forKey: rotationAnimation.keyPath)
    }
    override func stopAnimation() {
        rotationBaseLayer.removeAllAnimations()
        progressLayer.removeAllAnimations()
    }

}
