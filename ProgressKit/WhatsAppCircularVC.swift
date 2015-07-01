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
    
    @IBAction func toggleAnimation(sender: NSButton) {
        progressView.animate = sender.state == NSOnState
    }
}