//
//  Spinner.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 28/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

private let defaultForegroundColor = NSColor.whiteColor()
private let defaultBackgroundColor = NSColor(white: 0.0, alpha: 0.4)
private let duration = 1.2

class Spinner: IndeterminateAnimation {
    
    var basicShape = CAShapeLayer()
    
    var backgroundLayer = CAShapeLayer()
    var containerLayer = CAShapeLayer()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeLayers()
    }

    var animation: CAKeyframeAnimation = {
        var animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.duration = 1
        animation.repeatCount = 100
        animation.values = [Double]()
        animation.calculationMode = kCAAnimationDiscrete
        return animation
    }()
    
    func makeLayers() {
        self.wantsLayer = true
        let rect = self.bounds
        
        
        backgroundLayer.frame = self.bounds
        backgroundLayer.backgroundColor = NSColor ( red: 1.0, green: 0.1491, blue: 0.0, alpha: 0.13 ).CGColor
        self.layer?.addSublayer(backgroundLayer)
        
        
        containerLayer.frame = self.bounds
        containerLayer.cornerRadius = rect.width / 2
        backgroundLayer.addSublayer(containerLayer)

        let shapeSize = CGSize(width: 10, height: 30)
        let distance = CGFloat(24)
        let numberOfLines = 8
        for var i = 0.0; i < 360; i = i + Double(360 / numberOfLines) {
            animation.values.append(i * M_PI / 180.0)
            var shape = CAShapeLayer()
            shape.cornerRadius = shapeSize.width / 2
            shape.frame = CGRect(x: rect.midX - shapeSize.width / 2, y: rect.midY - shapeSize.height / 2, width: shapeSize.width, height: shapeSize.height)
            shape.backgroundColor = NSColor.redColor().CGColor
            shape.anchorPoint = CGPoint(x: 0.5, y: 0)
            var thirtyDegrees: CGFloat = CGFloat(i * M_PI / 180.0)
            
            var  rotation: CATransform3D = CATransform3DMakeTranslation(0, 0, 0.0);
            rotation = CATransform3DRotate(rotation, -thirtyDegrees, 0.0, 0.0, 1.0);
            rotation = CATransform3DTranslate(rotation, 0, distance, 0.0);
            shape.transform = rotation
            
            shape.opacity = Float(360 - i) / 360
            containerLayer.addSublayer(shape)
            
            containerLayer.addAnimation(animation, forKey: "rotation")
        }
    }
}