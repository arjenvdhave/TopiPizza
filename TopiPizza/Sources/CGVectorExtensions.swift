//
//  CGVectorExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 18-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension CGVector {
    
    init(length: CGFloat, angle: Angle) {
        
        dx = length * cos(angle.radians)
        dy = length * sin(angle.radians)
        
    }
    
    var length : CGFloat {
        
        return sqrt( pow(dx, 2) + pow(dy, 2) )
        
    }
    
}
