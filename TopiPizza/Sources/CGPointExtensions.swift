//
//  CGPointExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension CGPoint {
    
    func distance(other: CGPoint) -> CGFloat {
        
        return sqrt( pow( other.x - x, 2 ) + pow( other.y - y, 2 ) )
        
    }
    
    /// Calculates the absolute angle between `self`
    /// and the `other` point through the given `center`.
    func angle(other: CGPoint, center: CGPoint) -> Angle {
        
        let a = other.distance(center)
        let b = distance(center)
        let c = distance(other)
        
        return .Radians(acos(
            ( pow(a, 2) + pow(b, 2) - pow(c, 2) )
            /
            (2 * a * b)
        ))
        
    }
    
}