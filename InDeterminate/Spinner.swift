//
//  Spinner.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 28/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
public class Spinner: IndeterminateAnimation {
    
    var basicShape = CAShapeLayer()
    var containerLayer = CAShapeLayer()
    var starList = [CAShapeLayer]()
    
    var animation: CAKeyframeAnimation = {
        var animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.repeatCount = Float.infinity
        animation.calculationMode = kCAAnimationDiscrete
        return animation
        }()

    @IBInspectable var starSize:CGSize = CGSize(width: 6, height: 15) {
        didSet {
            notifyViewRedesigned()
        }
    }

    @IBInspectable var roundedCorners: Bool = true {
        didSet {
            notifyViewRedesigned()
        }
    }

    
    @IBInspectable var distance: CGFloat = CGFloat(20) {
        didSet {
            notifyViewRedesigned()
        }
    }

    @IBInspectable var starCount: Int = 10 {
        didSet {
            notifyViewRedesigned()
        }
    }

    @IBInspectable var duration: Double = 1 {
        didSet {
            animation.duration = duration
        }
    }

    @IBInspectable var clockwise: Bool = false {
        didSet {
            notifyViewRedesigned()
        }
    }

    override func configureLayers() {
        super.configureLayers()

        containerLayer.frame = self.bounds
        containerLayer.cornerRadius = frame.width / 2
        self.layer?.addSublayer(containerLayer)
        
        animation.duration = duration
    }
    
    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        starList.removeAll(keepCapacity: true)
        containerLayer.sublayers = nil
        animation.values = [Double]()

        for var i = 0.0; i < 360; i = i + Double(360 / starCount) {
            var iRadian = CGFloat(i * M_PI / 180.0)
            if clockwise { iRadian = -iRadian }

            animation.values?.append(iRadian)
            let starShape = CAShapeLayer()
            starShape.cornerRadius = roundedCorners ? starSize.width / 2 : 0

            let centerLocation = CGPoint(x: frame.width / 2 - starSize.width / 2, y: frame.width / 2 - starSize.height / 2)

            starShape.frame = CGRect(origin: centerLocation, size: starSize)

            starShape.backgroundColor = foreground.CGColor
            starShape.anchorPoint = CGPoint(x: 0.5, y: 0)

            var  rotation: CATransform3D = CATransform3DMakeTranslation(0, 0, 0.0);

            rotation = CATransform3DRotate(rotation, -iRadian, 0.0, 0.0, 1.0);
            rotation = CATransform3DTranslate(rotation, 0, distance, 0.0);
            starShape.transform = rotation

            starShape.opacity = Float(360 - i) / 360
            containerLayer.addSublayer(starShape)
            starList.append(starShape)
        }
    }

    override func startAnimation() {
        containerLayer.addAnimation(animation, forKey: "rotation")
    }
    
    override func stopAnimation() {
        containerLayer.removeAllAnimations()
    }
}
