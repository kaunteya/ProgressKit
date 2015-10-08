//
//  ViewController.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Cocoa

class DeterminateViewController: NSViewController {

    dynamic var liveProgress: Bool = true
    dynamic var labelPercentage: String = "30%"

    override func viewDidLoad() {
        preferredContentSize = NSMakeSize(500, 300)
    }

    @IBOutlet weak var slider: NSSlider!

    @IBAction func sliderDragged(sender: NSSlider) {

        let event = NSApplication.sharedApplication().currentEvent
//        let dragStart = event!.type == NSEventType.LeftMouseDown
        let dragEnd = event!.type == NSEventType.LeftMouseUp
//        let dragging = event!.type == NSEventType.LeftMouseDragged

        if liveProgress || dragEnd {
            setProgress(CGFloat(sender.floatValue))
        }
        labelPercentage = "\(Int(sender.floatValue * 100))%"
    }

    func setProgress(progress: CGFloat) {
        for view in self.view.subviews {
            if view is DeterminateAnimation {
                (view as! DeterminateAnimation).progress = progress
            }
        }
    }
    
}

