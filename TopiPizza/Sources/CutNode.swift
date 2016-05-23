//
//  CutNode.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import SpriteKit

class CutNode : SKShapeNode {
    
    convenience init(cut: Cut) {
        
        self.init()
        
        lineWidth = 4
        strokeColor = SKColor.blackColor()
        
        path = CGPath.line(from: cut.from, to: cut.to)
        
    }
    
}

