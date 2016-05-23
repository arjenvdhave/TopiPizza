//
//  Topping.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 23-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

enum Topping {
    
    case Tomato
    case Salami
    case Pepper
    case Mushroom
    case Pineapple
    case Ham
    
    
    
    // MARK: - Properties
    
    var score : Int {
        
        switch ( self ) {
        case Tomato, Mushroom:
            return 1
        case Salami, Ham:
            return 3
        case Pepper, .Pineapple:
            return 2
        }
        
    }
    
}
