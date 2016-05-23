//
//  IntExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension Int {
    
    /// Creates and returns a random integer number with the given boundaries.
    /// Note that the maximum should be higher than or equal to the minimum.
    /// The returned value can be the given minimum and up to, but not including, the given maximum.
    /// - returns: A random integer number within the given boundaries.
    static func random(min min: Int, max: Int) -> Int {
        
        let delta = max - min
        
        return ( delta > 0 ) ? min + Int(arc4random_uniform(UInt32(delta))) : 0
        
    }
    
    /// Creates and returns a random integer number with the given maximum.
    /// Note that the maximum should be higher than or equal to zero.
    /// The returned value can be from zero up to, but not including, the given maximum.
    /// - returns: A random integer number between zero and the given maximum.
    static func random(max: Int) -> Int {
        
        return random(min: 0, max: max)
        
    }
    
}
