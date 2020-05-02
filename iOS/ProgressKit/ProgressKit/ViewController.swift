//
//  ViewController.swift
//  ProgressKit-iOS
//
//  Created by BinaryBoy on 9/27/16.
//  Copyright © 2016 Kauntey Suryawanshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var spinView: Spinner!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        spinView.startAnimation()

    }
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in self.view.subviews {
            (view as? IndeterminateAnimation)?.configureLayers()
            (view as? IndeterminateAnimation)?.animate = true

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

