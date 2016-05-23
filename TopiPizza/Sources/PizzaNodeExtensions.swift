//
//  PizzaNodeExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 23-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension PizzaNode {
    
    var slice : Slice? {
        
        if let pizza = pizza where isSlice {
            return Slice(pizza: pizza, fromAngle: fromAngle, toAngle: toAngle)
        } else {
            return nil
        }
        
    }
    
}
