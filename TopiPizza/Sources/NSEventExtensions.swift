//
//  NSEventExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 23-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Cocoa

extension NSEvent {
    
    var key : Key? {
        
        return Key(rawValue: Int(keyCode))
        
    }
    
}
