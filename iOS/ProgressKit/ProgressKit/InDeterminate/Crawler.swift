//
//  Crawler.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 11/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import UIKit

private let defaultForegroundColor = UIColor.white
private let defaultBackgroundColor = UIColor(white: 0.0, alpha: 0.4)
private let duration = 1.2

@IBDesignable
open class Crawler: IndeterminateAnimation {
    
    var starList = [CAShapeLayer]()

    var smallCircleSize: Double {
        return Double(self.bounds.width) * 0.2
    }

    var animationGroups = [CAAnimation]()

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        for star in starList {
            star.backgroundColor = foreground.cgColor
        }
    }
    
    override func configureLayers() {
        super.configureLayers()
        let rect = self.bounds

        let insetRect = rect.insetBy(dx: rect.width * 0.15, dy: rect.width * 0.15)
        for i in 0 ..< 5 {
            let starShape = CAShapeLayer()
            starList.append(starShape)
            starShape.backgroundColor = foreground.cgColor

            let circleWidth = smallCircleSize - Double(i) * 2
            starShape.bounds = CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth)
            starShape.cornerRadius = CGFloat(circleWidth / 2)
            starShape.position = CGPoint(x: rect.midX, y: rect.midY + insetRect.height / 2)
            self.layer.addSublayer(starShape)

            let arcPath = UIBezierPath()
            arcPath.addArc(withCenter: insetRect.mid, radius: insetRect.width / 2, startAngle: 90, endAngle: -360 + 90, clockwise: true)

            let rotationAnimation = CAKeyframeAnimation(keyPath: "position")
            rotationAnimation.path = arcPath.cgPath
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rotationAnimation.beginTime = (duration * 0.075) * Double(i)
            rotationAnimation.calculationMode = kCAAnimationCubicPaced

            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [rotationAnimation]
            animationGroup.duration = duration
            animationGroup.repeatCount = Float.infinity
            animationGroups.append(animationGroup)

        }
    }

    override func startAnimation() {
        for (index, star) in starList.enumerated() {
            star.add(animationGroups[index], forKey: "")
        }
    }

    override func stopAnimation() {
        for star in starList {
            star.removeAllAnimations()
        }
    }

}

