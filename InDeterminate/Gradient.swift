//
//  Gradient.swift
//  ProgressKit
//
//  Created by Sam on 11/9/18.
//  Copyright © 2018 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
open class Gradient: IndeterminateAnimation {

    
    static let progressAnimationKey = "GradientAnimation"
    private let gradientLayer = CAGradientLayer()
    private let gradientView = NSView()

    /// Duration for the progress animation.
    var progressAnimationDuration: TimeInterval = 5.0
    
    /// Colors used for the gradient.
    var gradientColorList: [NSColor] = [NSColor.red, NSColor.green, NSColor.blue, NSColor.orange, NSColor.purple]
    
    
    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        
        
    }
    
    override func configureLayers() {
        super.configureLayers()
        
        gradientView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        gradientView.wantsLayer = true
        addSubview(gradientView)
        
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)
        gradientLayer.position = .zero

        gradientLayer.anchorPoint = .zero
        
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        var reversedColorList = Array(gradientColorList.reversed())
        reversedColorList.removeFirst()
        reversedColorList.removeLast()
        
        let infinteColorList = gradientColorList + reversedColorList + gradientColorList
        gradientLayer.colors = infinteColorList.map({ $0.cgColor })
        
        gradientView.layer?.insertSublayer(gradientLayer, at: 0)
    }
    //MARK: Indeterminable protocol
    override func startAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.fromValue = CGPoint(x: -2 * bounds.size.width, y: 0)
        animation.toValue = CGPoint.zero
        animation.duration = progressAnimationDuration
        animation.repeatCount = Float.infinity
        
        // Prevent stopping animation on disappearing view, and then coming back.
        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: Gradient.progressAnimationKey)
    }
    
    override func stopAnimation() {
        gradientLayer.removeAnimation(forKey: Gradient.progressAnimationKey)
    }
}
