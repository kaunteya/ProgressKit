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
public class Crawler: IndeterminateAnimation {
    
    var starList = [CAShapeLayer]()

    var smallCircleSize: Double {
        return Double(self.bounds.width) * 0.2
    }

    var animationGroups = [CAAnimation]()

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        for star in starList {
            star.backgroundColor = foreground.CGColor
        }
    }
    override func configureLayers() {
        super.configureLayers()
        let rect = self.bounds
        let insetRect = NSInsetRect(rect, rect.width * 0.15, rect.width * 0.15)

        for var i = 0.0; i < 5; i++ {
            let starShape = CAShapeLayer()
            starList.append(starShape)
            starShape.backgroundColor = foreground.CGColor

            let circleWidth = smallCircleSize - i * 2
            starShape.bounds = CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth)
            starShape.cornerRadius = CGFloat(circleWidth / 2)
            starShape.position = CGPoint(x: rect.midX, y: rect.midY + insetRect.height / 2)
            self.layer?.addSublayer(starShape)

            let arcPath = NSBezierPath()
            arcPath.appendBezierPathWithArcWithCenter(insetRect.mid, radius: insetRect.width / 2, startAngle: 90, endAngle: -360 + 90, clockwise: true)

            let rotationAnimation = CAKeyframeAnimation(keyPath: "position")
            rotationAnimation.path = arcPath.CGPath
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rotationAnimation.beginTime = (duration * 0.075) * i
            rotationAnimation.calculationMode = kCAAnimationCubicPaced

            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [rotationAnimation]
            animationGroup.duration = duration
            animationGroup.repeatCount = Float.infinity
            animationGroups.append(animationGroup)

        }
    }

    override func startAnimation() {
        for (index, star) in starList.enumerate() {
            star.addAnimation(animationGroups[index], forKey: "")
        }
    }

    override func stopAnimation() {
        for star in starList {
            star.removeAllAnimations()
        }
    }
}

