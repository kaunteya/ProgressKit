//
//  DeterminateAnimation.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 09/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

protocol Determinable {
    func updateProgress()
}

@IBDesignable
class DeterminateAnimation: NSView, Determinable {
    
    @IBInspectable var animated: Bool = true

    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }

    func updateProgress() {
        fatalError("Must be overriden in subclass")
    }
}
