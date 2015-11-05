//
//  InDeterminateAnimation.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 09/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

protocol AnimationActivityProtocol {
    func startAnimation()
    func stopAnimation()
}

public class IndeterminateAnimation: BaseView, AnimationActivityProtocol {

    /// View is hidden when *animate* property is false
    @IBInspectable var displayAfterAnimationEnds: Bool = false

    /**
    Control point for all Indeterminate animation
    True invokes `startAnimation()` on subclass of IndeterminateAnimation
    False invokes `stopAnimation()` on subclass of IndeterminateAnimation
    */
    public var animate: Bool = false {
        didSet {
            if animate {
                self.hidden = false
                startAnimation()
            } else {
                if !displayAfterAnimationEnds {
                    self.hidden = true
                }
                stopAnimation()
            }
        }
    }

    /**
    Every function that extends Indeterminate animation must define startAnimation().
    `animate` property of Indeterminate animation will indynamically invoke the subclass method
    */
    func startAnimation() {
        fatalError("This is an abstract function")
    }

    /**
    Every function that extends Indeterminate animation must define **stopAnimation()**.

    *animate* property of Indeterminate animation will dynamically invoke the subclass method
    */
    func stopAnimation() {
        fatalError("This is an abstract function")
    }
}
