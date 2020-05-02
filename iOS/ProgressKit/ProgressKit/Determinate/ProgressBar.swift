//
//  ProgressBar.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 31/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class ProgressBar: DeterminateAnimation {

    var borderLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    
    @IBInspectable open var borderColor: UIColor = UIColor.black {
        didSet {
            notifyViewRedesigned()
        }
    }

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        self.layer.cornerRadius = self.frame.height / 2
        borderLayer.borderColor = borderColor.cgColor
        progressLayer.backgroundColor = foreground.cgColor
    }

    override func configureLayers() {
        super.configureLayers()

        borderLayer.frame = self.bounds
        borderLayer.cornerRadius = borderLayer.frame.height / 2
        borderLayer.borderWidth = 1.0
        self.layer.addSublayer(borderLayer)

        progressLayer.frame = borderLayer.bounds.insetBy(dx: 3, dy: 3)
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6)
        progressLayer.cornerRadius = progressLayer.frame.height / 2
        progressLayer.backgroundColor = foreground.cgColor
        borderLayer.addSublayer(progressLayer)

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
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6) * progress
        CATransaction.commit()
    }
}
