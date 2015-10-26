//
//  ProgressUtils.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 09/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//


import AppKit

extension NSRect {
    var mid: CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
}

extension NSBezierPath {
    /// Converts NSBezierPath to CGPath
    var CGPath: CGPathRef {
        let path = CGPathCreateMutable()
        let points = UnsafeMutablePointer<NSPoint>.alloc(3)
        let numElements = self.elementCount

        for index in 0..<numElements {
            let pathType = self.elementAtIndex(index, associatedPoints: points)
            switch pathType {
            case .MoveToBezierPathElement:
                CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
            case .LineToBezierPathElement:
                CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
            case .CurveToBezierPathElement:
                CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
            case .ClosePathBezierPathElement:
                CGPathCloseSubpath(path)
            }
        }

        points.dealloc(3)
        return path
    }
}

func degreeToRadian(degree: Int) -> Double {
    return Double(degree) * (M_PI / 180)
}

func radianToDegree(radian: Double) -> Int {
    return Int(radian * (180 / M_PI))
}

func + (p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

