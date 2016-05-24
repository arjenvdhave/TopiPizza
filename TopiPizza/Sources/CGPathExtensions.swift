//
//  CGPathExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension CGMutablePath {
    
    func moveTo(point: CGPoint) {
        
        CGPathMoveToPoint(self, nil, point.x, point.y)
        
    }
    
    func addLineTo(point: CGPoint) {
        
        CGPathAddLineToPoint(self, nil, point.x, point.y)
        
    }
    
    func arc(center center: CGPoint, radius: CGFloat, fromAngle: Angle, toAngle: Angle, clockwise: Bool) {
        
        let from = Angle.Degrees(fromAngle.degrees)
        let to = Angle.Degrees(toAngle.degrees)
        
        CGPathAddArc(self, nil, center.x, center.y, radius, from.radians, to.radians, clockwise)
        
    }
    
    func flipped(radius: CGFloat) -> CGMutablePath {
        
        var transform = CGAffineTransformMake(1, 0, 0, -1, 0, radius * 2)
        return CGPathCreateMutableCopyByTransformingPath(self, &transform) ?? CGPathCreateMutableCopy(self) ??  self
        
    }
    
}

extension CGPath {
    
    var bounds : CGRect {
        
        return CGPathGetPathBoundingBox(self)
        
    }
    
    func contains(point: CGPoint) -> Bool {
        
        return CGPathContainsPoint(self, nil, point, true)
        
    }
    
    func near(path: CGPath) -> Bool {
        
        return CGRectIntersectsRect(path.bounds, bounds)
        
    }
    
    static func line(from from: CGPoint, to: CGPoint) -> CGMutablePath {
        
        let path = CGPathCreateMutable()
        path.moveTo(from)
        path.addLineTo(to)
        
        return path
        
    }
    
    static func pie(center center: CGPoint, radius: CGFloat, fromAngle: Angle, toAngle: Angle, offsetAngle: Angle, clockwise: Bool) -> CGMutablePath {
        
        let path = CGPathCreateMutable()
        
        path.moveTo(center)
        path.arc(
            center: center,
            radius: radius,
            fromAngle: .Degrees(fromAngle.degrees + offsetAngle.degrees),
            toAngle: .Degrees(toAngle.degrees + offsetAngle.degrees),
            clockwise: clockwise
        )
        path.addLineTo(center)
        
        return path.flipped(radius)
        
    }
    
    static func circle(center center: CGPoint, radius: CGFloat) -> CGMutablePath {
        
        let path = CGPathCreateMutable()
        
        path.arc(
            center: center,
            radius: radius,
            fromAngle: .Degrees(0),
            toAngle: .Degrees(360),
            clockwise: false
        )
        
        return path
        
    }
    
}