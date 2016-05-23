//
//  Angle.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 19-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

let π = CGFloat(M_PI)

enum Angle {
    
    case Degrees(CGFloat)
    case Radians(CGFloat)
    
    
    
    // MARK: - Properties
    
    var degrees : CGFloat {
        
        let d : CGFloat
        
        switch ( self ) {
            
        case .Degrees(let degrees):
            d = degrees
        case .Radians(let radians):
            d = Angle.radiansToDegrees(radians)
            
        }
        
        return d
        
    }
    
    var radians : CGFloat {
        
        let r : CGFloat
        
        switch ( self ) {
            
        case .Degrees(let degrees):
            r = Angle.degreesToRadians(degrees)
        case .Radians(let radians):
            r = radians
            
        }
        
        return r
        
    }
    
    
    // MARK: - Construction
    
    init() {
        
        self = .Degrees(0)
        
    }
    
    
    
    // MARK: - Private Functions
    
    private static func degreesToRadians(degrees: CGFloat) -> CGFloat {
        
        return degrees * (π / 180)
        
    }
    
    private static func radiansToDegrees(radians: CGFloat) -> CGFloat {
        
        return radians * (180 / π)
        
    }
    
}
