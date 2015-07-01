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
    override func viewDidLoad() {
        preferredContentSize = NSMakeSize(500, 500)
    }

    @IBOutlet weak var progressView: WhatsAppCircular!
    
    @IBOutlet weak var modu: WhatsAppCircular!
    @IBOutlet weak var medi: WhatsAppCircular!
    @IBOutlet weak var small: WhatsAppCircular!
    @IBAction func toggleAnimation(sender: NSButton) {
        progressView.animate = sender.state == NSOnState
        modu.animate = sender.state == NSOnState
        medi.animate = sender.state == NSOnState
        small.animate = sender.state == NSOnState
    }
}