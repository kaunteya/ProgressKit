//
//  RotatingArc.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 26/10/15.
//  Copyright © 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

private let duration = 0.25

@IBDesignable
public class RotatingArc: IndeterminateAnimation {

    var backgroundCircle = CAShapeLayer()
    var arcLayer = CAShapeLayer()

    @IBInspectable var strokeWidth: CGFloat = 5 {
        didSet {
            notifyViewRedesigned()
        }
    }

    @IBInspectable var arcLength: Int = 35 {
        didSet {
            notifyViewRedesigned()
        }
    }

    @IBInspectable var clockWise: Bool = true {
        didSet {
            notifyViewRedesigned()
        }
    }

    var radius: CGFloat {
        return (self.frame.width / 2) * CGFloat(0.75)
    }

    var rotationAnimation: CABasicAnimation = {
        var tempRotation = CABasicAnimation(keyPath: "transform.rotation")
        tempRotation.repeatCount = Float.infinity
        tempRotation.fromValue = 0
        tempRotation.toValue = 1
        tempRotation.cumulative = true
        tempRotation.duration = duration
        return tempRotation
        }()

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()

        arcLayer.strokeColor = foreground.CGColor
        backgroundCircle.strokeColor = foreground.colorWithAlphaComponent(0.4).CGColor

        backgroundCircle.lineWidth = self.strokeWidth
        arcLayer.lineWidth = strokeWidth
        rotationAnimation.toValue = clockWise ? -1 : 1

        let arcPath = NSBezierPath()
        let endAngle: CGFloat = CGFloat(-360) * CGFloat(arcLength) / 100
        arcPath.appendBezierPathWithArcWithCenter(self.bounds.mid, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)

        arcLayer.path = arcPath.CGPath
    }

    override func configureLayers() {
        super.configureLayers()
        let rect = self.bounds

        // Add background Circle
        do {
            backgroundCircle.frame = rect
            backgroundCircle.lineWidth = strokeWidth

            backgroundCircle.strokeColor = foreground.colorWithAlphaComponent(0.5).CGColor
            backgroundCircle.fillColor = NSColor.clearColor().CGColor
            let backgroundPath = NSBezierPath()
            backgroundPath.appendBezierPathWithArcWithCenter(rect.mid, radius: radius, startAngle: 0, endAngle: 360)
            backgroundCircle.path = backgroundPath.CGPath
            self.layer?.addSublayer(backgroundCircle)
        }

        // Arc Layer
        do {
            arcLayer.fillColor = NSColor.clearColor().CGColor
            arcLayer.lineWidth = strokeWidth

            arcLayer.frame = rect
            arcLayer.strokeColor = foreground.CGColor
            self.layer?.addSublayer(arcLayer)
        }
    }

    override func startAnimation() {
        arcLayer.addAnimation(rotationAnimation, forKey: "")
    }

    override func stopAnimation() {
        arcLayer.removeAllAnimations()
    }
}
