//
//  Crawler.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 11/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

private let defaultForegroundColor = NSColor.whiteColor()
private let defaultBackgroundColor = NSColor(white: 0.0, alpha: 0.4)
private let duration = 1.2

@IBDesignable
class Crawler: IndeterminateAnimation {
    
    var backgroundLayer = CAShapeLayer()
    var starList = [CAShapeLayer]()
    @IBInspectable var backgroundColor: NSColor = defaultBackgroundColor {
        didSet {
            backgroundLayer.backgroundColor = backgroundColor.CGColor
        }
    }
    
    @IBInspectable var foregroundColor: NSColor = defaultForegroundColor {
        didSet {
            for star in starList {
                star.backgroundColor = foregroundColor.CGColor
            }
        }
    }
    var smallCircleSize: Double {
        get {
            return Double(self.bounds.width) * 0.2
        }
    }

    var cornerRadius: CGFloat {
        get {
            return self.bounds.width * 0.13
        }
    }
    var animationGroups = [CAAnimationGroup]()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        makeLayer()
    }
    
    func makeLayer() {
        let rect = self.bounds
        let insetRect = NSInsetRect(rect, rect.width * 0.15, rect.width * 0.15)

        backgroundLayer.backgroundColor = backgroundColor.CGColor
        backgroundLayer.frame = self.bounds
        backgroundLayer.cornerRadius = cornerRadius
        self.layer?.addSublayer(backgroundLayer)
        
        do_ {
            var circleWidthSummation = 0.0
            for var i = 1; i < 5; i++ {
                var starLayer = CAShapeLayer()
                starList.append(starLayer)
                starLayer.backgroundColor = foregroundColor.CGColor
                
                let circleWidth = smallCircleSize - Double(i * 2)
                circleWidthSummation += circleWidth
                starLayer.bounds = CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth)
                starLayer.cornerRadius = CGFloat(smallCircleSize / 2)
                starLayer.position = CGPoint(x: rect.midX, y: rect.midY + insetRect.height / 2)
                self.layer?.addSublayer(starLayer)
                
                var arcPath = NSBezierPath()
                arcPath.appendBezierPathWithArcWithCenter(insetRect.mid, radius: insetRect.width / 2, startAngle: 90, endAngle: -360 + 90, clockwise: true)
                
                var rotationAnimation = CAKeyframeAnimation(keyPath: "position")
                rotationAnimation.path = arcPath.CGPath
                rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                rotationAnimation.duration = duration
                rotationAnimation.beginTime = circleWidthSummation / Double(insetRect.width) * 0.6
                rotationAnimation.calculationMode = kCAAnimationCubicPaced
                
                var animationGroup = CAAnimationGroup()
                animationGroup.animations = [rotationAnimation]
                animationGroup.duration = duration
                animationGroup.repeatCount = Float.infinity
                animationGroup.removedOnCompletion = false
                animationGroups.append(animationGroup)
            }
        }
    }
    override func startAnimation() {
        for (index, star) in enumerate(starList) {
            star.addAnimation(animationGroups[index], forKey: "")
        }
    }
    override func stopAnimation() {
        for star in starList {
            star.removeAllAnimations()
        }
    }

}

