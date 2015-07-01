//
//  WhatsAppCircular.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

class WhatsAppCircularVC: NSViewController {
    @IBOutlet weak var progressView: WhatsAppCircular!
    
    @IBOutlet weak var testSlider: NSSlider!
    
    @IBOutlet weak var testLabel: NSTextField!

    @IBAction func testSliderUpdated(sender: NSSlider) {

        println("Slider \(sender.floatValue)")
        testLabel.stringValue = String(stringInterpolationSegment: sender.floatValue)
        progressView.stopAnimation()
        progressView.startAnimation(CGFloat(sender.floatValue))
        
    }
    @IBAction func toggleAnimation(sender: NSButton) {
        let toggle = sender.state == NSOnState
        if toggle {
            progressView.startAnimation(CGFloat(testSlider.floatValue))
        } else {
            progressView.stopAnimation()
        }
    }
}