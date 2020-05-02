//
//  BaseView.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 04/10/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
open class BaseView : UIView {

    override public init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.configureLayers()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        //self.configureLayers()
    }

    /// Configure the Layers
    func configureLayers() {
        //self.wantsLayer = true
        notifyViewRedesigned()
    }

    @IBInspectable open var background: UIColor = UIColor(red: 88.3 / 256, green: 104.4 / 256, blue: 118.5 / 256, alpha: 1.0) {
        didSet {
            self.notifyViewRedesigned()
        }
    }

    @IBInspectable open var foreground: UIColor = UIColor(red: 66.3 / 256, green: 173.7 / 256, blue: 106.4 / 256, alpha: 1.0) {
        didSet {
            self.notifyViewRedesigned()
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.notifyViewRedesigned()
        }
    }

    /// Call when any IBInspectable variable is changed
    func notifyViewRedesigned() {
        self.layer.backgroundColor = background.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        //self.frame will be correct here
        configureLayers()
    }
}
