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
    
    @IBOutlet weak var circularView1: CircularProgressView?
    @IBOutlet weak var circularView2: CircularProgressView?
    @IBOutlet weak var circularView3: CircularProgressView?
    @IBOutlet weak var circularView4: CircularProgressView?
    @IBOutlet weak var circularView5: CircularProgressView?

    @IBOutlet weak var progressBar1: ProgressBar?
    @IBOutlet weak var progressBar2: ProgressBar?

    
    @IBAction func sliderDragged(sender: NSSlider) {

        let event = NSApplication.sharedApplication().currentEvent
        let dragStart = event!.type == NSEventType.LeftMouseDown
        let dragEnd = event!.type == NSEventType.LeftMouseUp
        let dragging = event!.type == NSEventType.LeftMouseDragged

        if liveProgress || dragEnd {
            setProgress(CGFloat(sender.floatValue))
        }
        labelPercentage = "\(Int(sender.floatValue * 100))%"
    }

    func setProgress(progress: CGFloat) {
        circularView1?.progress = progress
        circularView2?.progress = progress
        circularView3?.progress = progress
        circularView4?.progress = progress
        circularView5?.progress = progress
        progressBar1?.progress = progress
        progressBar2?.progress = progress
    }
    
}

