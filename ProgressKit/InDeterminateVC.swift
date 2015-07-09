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
    override func viewDidLoad() {
        preferredContentSize = NSMakeSize(500, 500)
    }

    /// MARK: DoingCircular
    @IBOutlet weak var doing1: CircularSnail!
    @IBOutlet weak var doing2: CircularSnail!
    @IBOutlet weak var doing3: CircularSnail!
    @IBOutlet weak var doing4: CircularSnail!
    
    @IBAction func animateDoing(sender: NSButton) {
        let isOn = sender.state == NSOnState
        doing1.animate = isOn
        doing2.animate = isOn
        doing3.animate = isOn
        doing4.animate = isOn
    }
    
    /// Shooting Stars
    @IBOutlet weak var shootingStar1: ShootingStars!
    @IBOutlet weak var shootingStar2: ShootingStars!
    @IBOutlet weak var shootingStar3: ShootingStars!
    
    @IBAction func animateShootingStars(sender: NSButton) {
        let isOn = sender.state == NSOnState
        shootingStar1.animate = isOn

        shootingStar2.animate = isOn
        shootingStar3.animate = isOn
//        shootingStar4.animate = isOn
    }
    
    
}