//
//  CircularView.swift
//  Animo
//
//  Created by Kauntey Suryawanshi on 29/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
class CircularProgressView: DeterminateAnimation {
    var backgroundLayer = CAShapeLayer()
    var backgroundCircle = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    var percentLabelLayer = CATextLayer()

    @IBInspectable var color: NSColor = NSColor.whiteColor() {
        didSet {
            backgroundCircle.strokeColor = color.colorWithAlphaComponent(0.5).CGColor
            progressLayer.strokeColor = color.CGColor
            percentLabelLayer.foregroundColor = color.CGColor
        }
    }
    
    @IBInspectable var backgroundColor: NSColor = NSColor(calibratedWhite: 0, alpha: 0.39) {
        didSet {
            backgroundLayer.fillColor = backgroundColor.CGColor
        }
    }
    
    @IBInspectable var strokeWidth: CGFloat = -1 {
        didSet {
            backgroundCircle.lineWidth = self.strokeWidth / 2
            progressLayer.lineWidth = strokeWidth
        }
    }
    
    @IBInspectable var showPercent: Bool = true {
        didSet {
            percentLabelLayer.hidden = !showPercent
        }
    }
    override func updateProgress() {
        CATransaction.begin()
        if animated {
            CATransaction.setAnimationDuration(0.5)
        } else {
            CATransaction.setDisableActions(true)
        }
        let timing = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        CATransaction.setAnimationTimingFunction(timing)
        progressLayer.strokeEnd = max(0, min(progress, 1))
        percentLabelLayer.string = "\(Int(progress * 100))%"
        CATransaction.commit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        makeLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }
    
    //TODO: Add percentage option to be shown in center of circle. Use CATextLayer
    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        let radius = (rect.width / 2) * 0.75
        let strokeScalingFactor = CGFloat(0.05)
        
        /// Add background layer
        do_ {
            let radius = NSWidth(rect) * 0.1
            backgroundLayer.frame = rect
            backgroundLayer.fillColor = backgroundColor.CGColor
            var backgroundPath = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
            backgroundLayer.path = backgroundPath.CGPath
            self.layer?.addSublayer(backgroundLayer)
        }
        
        /// Add background Circle
        do_ {
            backgroundCircle.frame = rect
            backgroundCircle.lineWidth = strokeWidth == -1 ? (rect.width * strokeScalingFactor / 2) : strokeWidth / 2
            
            backgroundCircle.strokeColor = color.colorWithAlphaComponent(0.5).CGColor
            backgroundCircle.fillColor = NSColor.clearColor().CGColor
            var backgroundPath = NSBezierPath()
            backgroundPath.appendBezierPathWithArcWithCenter(rect.mid, radius: radius, startAngle: 0, endAngle: 360)
            backgroundCircle.path = backgroundPath.CGPath
            self.layer?.addSublayer(backgroundCircle)
        }
        
        /// Progress Layer
        do_ {
            progressLayer.strokeEnd = 0 //REMOVe this
            progressLayer.fillColor = NSColor.clearColor().CGColor
            progressLayer.lineCap = kCALineCapRound
            progressLayer.lineWidth = strokeWidth == -1 ? (rect.width * strokeScalingFactor) : strokeWidth
            
            progressLayer.frame = rect
            progressLayer.strokeColor = color.CGColor
            var arcPath = NSBezierPath()
            var startAngle = CGFloat(90)
            arcPath.appendBezierPathWithArcWithCenter(rect.mid, radius: radius, startAngle: startAngle, endAngle: (startAngle - 360), clockwise: true)
            progressLayer.path = arcPath.CGPath
            self.layer?.addSublayer(progressLayer)
        }
        
        do_ {
            percentLabelLayer.string = "0%"
            percentLabelLayer.foregroundColor = color.CGColor
            percentLabelLayer.frame = rect
            percentLabelLayer.font = NSFont(name: "Helvetica Neue Light", size: 25)
            percentLabelLayer.alignmentMode = kCAAlignmentCenter
            percentLabelLayer.position.y = rect.midY * 0.25
            percentLabelLayer.fontSize = rect.width * 0.2
            self.layer!.addSublayer(percentLabelLayer)
        }
    }
}
