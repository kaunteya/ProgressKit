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
        animation.repeatCount = Float.infinity
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
        
        let innerFrame = NSInsetRect(self.bounds, self.bounds.width * 0.05, self.bounds.height * 0.05)
        containerLayer.frame = innerFrame
        containerLayer.cornerRadius = innerFrame.width / 2
        containerLayer.borderWidth  = 1
        backgroundLayer.addSublayer(containerLayer)

        let starSize = CGSize(width: 6, height: 15)
        let distance = CGFloat(24)
        let numberOfLines = 10
        for var i = 0.0; i < 360; i = i + Double(360 / numberOfLines) {
            let iRadian = i * M_PI / 180.0
            animation.values.append(iRadian)
            var starShape = CAShapeLayer()
            starShape.cornerRadius = starSize.width / 2
            starShape.frame = CGRect(x: innerFrame.width / 2 - starSize.width / 2, y: innerFrame.width / 2 - starSize.height / 2, width: starSize.width, height: starSize.height)
            starShape.backgroundColor = NSColor.redColor().CGColor
            starShape.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            var  rotation: CATransform3D = CATransform3DMakeTranslation(0, 0, 0.0);
            rotation = CATransform3DRotate(rotation, -CGFloat(iRadian), 0.0, 0.0, 1.0);
            rotation = CATransform3DTranslate(rotation, 0, distance, 0.0);
            starShape.transform = rotation
            
            starShape.opacity = Float(360 - i) / 360
            containerLayer.addSublayer(starShape)
        }
    }
    
    override func startAnimation() {
        containerLayer.addAnimation(animation, forKey: "rotation")
    }
    
    override func stopAnimation() {
        containerLayer.removeAllAnimations()
    }
}