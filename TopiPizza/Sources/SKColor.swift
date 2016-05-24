//
//  SKColor.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 19-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import SpriteKit

extension SKColor {
    
    // MARK: - Properties
    
    static var positiveColor : SKColor {
        
        return SKColor(red: 126, green: 211, blue: 33)
        
    }
    
    static var negativeColor : SKColor {
        
        return SKColor(red: 208, green: 2, blue: 27)
        
    }
    
    
    // MARK: - Construction
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        self.init(
            deviceRed: CGFloat(red)/256,
            green: CGFloat(green)/256,
            blue: CGFloat(blue)/256,
            alpha: 1
        )
        
    }
    
    
    // MARK: - Functions
    
    func setFill(context: CGContext) {
        
        if let fill = colorUsingColorSpace(NSColorSpace.deviceRGBColorSpace()) {
            
            CGContextSetRGBFillColor(
                context,
                fill.redComponent,
                fill.greenComponent,
                fill.blueComponent,
                fill.alphaComponent
            )
            
        }
        
    }
    
    static func randomPastel() -> SKColor {
        
        return random(base: SKColor.whiteColor())
        
    }
    
    static func random(base base: SKColor) -> SKColor {
        
        var red = CGFloat(Int.random(256)) / 256
        var green = CGFloat(Int.random(256)) / 256
        var blue = CGFloat(Int.random(256)) / 256
        
        if let base = base.colorUsingColorSpace(NSColorSpace.deviceRGBColorSpace()) {
            
            red = (red + base.redComponent) / 2
            green = (green + base.greenComponent) / 2
            blue = (blue + base.blueComponent) / 2
            
        }
        
        return SKColor(deviceRed: red, green: green, blue: blue, alpha: 1)
        
    }
    
}
