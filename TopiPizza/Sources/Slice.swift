//
//  Slice.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

struct Slice {
    
    var pizza : Pizza
    var fromAngle : Angle
    var toAngle : Angle
    
    var angle : Angle {
        
        return .Degrees(toAngle.degrees - fromAngle.degrees)
        
    }
    
}
