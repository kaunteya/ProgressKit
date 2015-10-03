//
//  ProgressUtils.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 09/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//


import AppKit
class View : NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
    }

}

extension NSRect {
    var mid: CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
}

extension NSBezierPath {
    var CGPath: CGPathRef {
        get {
            return self.convertToCGPath()
        }
    }
    
    /// Transforms the NSBezierPath into a CGPathRef
    ///
    /// :returns: The transformed NSBezierPath
    private func convertToCGPath() -> CGPathRef {
        
        // Create path
        var path = CGPathCreateMutable()
        var points = UnsafeMutablePointer<NSPoint>.alloc(3)
        let numElements = self.elementCount
        
        if numElements > 0 {
            var didClosePath = true
            for index in 0..<numElements {
                let pathType = self.elementAtIndex(index, associatedPoints: points)
                switch pathType {
                case .MoveToBezierPathElement:
                    CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
                case .LineToBezierPathElement:
                    CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
                    didClosePath = false
                case .CurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
                    didClosePath = false
                case .ClosePathBezierPathElement:
                    CGPathCloseSubpath(path)
                    didClosePath = true
                }
            }
            if !didClosePath { CGPathCloseSubpath(path) }
        }
        points.dealloc(3)
        return path
    }
}

/// All the do_ invocations will be replace by do after Swift 2.0
func do_ (@noescape work: () -> ()) {
    work()
}