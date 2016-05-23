//
//  CGRectExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 18-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension CGRect {
    
    var area : CGFloat {
        
        return width * height
        
    }
    
    var center : CGPoint {
        
        return CGPoint(
            x: origin.x + (width / 2),
            y: origin.y + (height / 2)
        )
        
    }
    
    func expand(distance: CGFloat) -> CGRect {
        
        var expanded = self
        
        expanded.origin.x -= distance
        expanded.origin.y -= distance
        expanded.size.width += distance
        expanded.size.height += distance
        
        return expanded
        
    }
    
}
