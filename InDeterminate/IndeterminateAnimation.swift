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
    @IBInspectable var displayAfterAnimationEnds: Bool = false

    var animate: Bool = false {
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
    func startAnimation() {
        fatalError("This is an abstract function")
    }
    func stopAnimation() {
        fatalError("This is an abstract function")
    }
}