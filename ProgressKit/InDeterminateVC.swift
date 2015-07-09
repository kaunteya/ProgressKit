//
//  WhatsAppCircular.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

class InDeterminateViewController: NSViewController {
    @IBOutlet weak var doing1: DoingCircular!
    @IBOutlet weak var doing2: DoingCircular!
    @IBOutlet weak var doing3: DoingCircular!
    @IBOutlet weak var doing4: DoingCircular!
    
    override func viewDidLoad() {
        preferredContentSize = NSMakeSize(500, 500)
    }
    
    @IBAction func startStopAnimation(sender: NSButton) {
        let isOn = sender.state == NSOnState
        doing1.animate = isOn
        doing2.animate = isOn
        doing3.animate = isOn
        doing4.animate = isOn
    }
}