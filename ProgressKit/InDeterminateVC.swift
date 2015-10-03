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

    // MARK: DoingCircular
    @IBOutlet weak var doing1: CircularSnail?
    @IBOutlet weak var doing2: CircularSnail?
    @IBOutlet weak var doing3: CircularSnail?
    @IBOutlet weak var doing4: CircularSnail?

    @IBAction func animateCircularSnail(sender: NSButton) {
        let isOn = sender.state == NSOnState
        doing1?.animate = isOn
        doing2?.animate = isOn
        doing3?.animate = isOn
        doing4?.animate = isOn
    }

    //MARK: Rainbow
    @IBOutlet weak var lightRainbow: Rainbow?
    @IBOutlet weak var darkRainbow: Rainbow?
    @IBAction func animateRainbow(sender: NSButton) {
        let isOn = sender.state == NSOnState
        lightRainbow?.animate = isOn
        darkRainbow?.animate = isOn
    }


    //MARK: Shooting Stars
    @IBOutlet weak var shootingStar1: ShootingStars?
    @IBOutlet weak var shootingStar2: ShootingStars?
    @IBOutlet weak var shootingStar3: ShootingStars?

    @IBAction func animateShootingStars(sender: NSButton) {
        let isOn = sender.state == NSOnState
        shootingStar1?.animate = isOn
        shootingStar2?.animate = isOn
        shootingStar3?.animate = isOn
    }

    //MARK: Crawlers
    @IBOutlet weak var crawler2: Crawler?
    @IBOutlet weak var crawler1: Crawler?
    @IBAction func animateCrawler(sender: NSButton) {
        let isOn = sender.state == NSOnState
        crawler1?.animate = isOn
        crawler2?.animate = isOn
    }

    //MARK: Spinners
    @IBOutlet weak var spinner1: Spinner?
    @IBOutlet weak var spinner2: Spinner?
    @IBOutlet weak var spinner3: Spinner?
    @IBOutlet weak var spinner4: Spinner?
    @IBOutlet weak var spinner5: Spinner?
    @IBOutlet weak var spinner6: Spinner?

    @IBOutlet weak var spinner7_1: Spinner?
    @IBOutlet weak var spinner7_2: Spinner?
    @IBOutlet weak var spinner7_3: Spinner?
    @IBOutlet weak var spinner8_1: Spinner?
    @IBOutlet weak var spinner8_2: Spinner?

    @IBAction func animateSpinner(sender: NSButton) {
        let isOn = sender.state == NSOnState
        spinner1?.animate = isOn
        spinner2?.animate = isOn
        spinner3?.animate = isOn
        spinner4?.animate = isOn
        spinner5?.animate = isOn
        spinner6?.animate = isOn
        spinner7_1?.animate = isOn
        spinner7_2?.animate = isOn
        spinner7_3?.animate = isOn
        spinner8_1?.animate = isOn
        spinner8_2?.animate = isOn
    }


}
