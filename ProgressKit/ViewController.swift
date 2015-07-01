//
//  ViewController.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 30/06/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var small: CircularProgressView!
    @IBOutlet weak var medium: CircularProgressView!
    @IBOutlet weak var large: CircularProgressView!
    @IBOutlet weak var progressView: CircularProgressView!
    
    @IBAction func continousSlider(sender: NSSlider) {
        let sliderValue: CGFloat = CGFloat(sender.floatValue)
        progressView.setProgressValue(sliderValue, animated: true)
        small.setProgressValue(sliderValue, animated: true)
        medium.setProgressValue(sliderValue, animated: true)
        large.setProgressValue(sliderValue, animated: true)
    }
    
    
    @IBOutlet weak var sliderOne: NSSlider!
    @IBAction func buttonPressed(sender: AnyObject) {
        let sliderValue: CGFloat = CGFloat(sliderOne.floatValue)
        progressView.setProgressValue(sliderValue, animated: true)
        small.setProgressValue(sliderValue, animated: true)
        medium.setProgressValue(sliderValue, animated: true)
        large.setProgressValue(sliderValue, animated: true)
    }
}

