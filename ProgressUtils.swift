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
        return CGPoint(x: self.midX, y: self.midY)
    }
}

extension NSBezierPath {
    /// Converts NSBezierPath to CGPath
    var CGPath: CGPath {
        let path = CGMutablePath()
        let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)
        let numElements = self.elementCount

        for index in 0..<numElements {
            let pathType = self.element(at: index, associatedPoints: points)
            switch pathType {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                print("")
            }
        }

        points.deallocate()
        return path
    }
}

func degreeToRadian(_ degree: Int) -> Double {
    return Double(degree) * (Double.pi / 180)
}

func radianToDegree(_ radian: Double) -> Int {
    return Int(radian * (180 / Double.pi))
}

func + (p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

