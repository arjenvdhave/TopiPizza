//
//  Pizza.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

enum Pizza {
    
    case Burnt
    case Tomato
    case Pepper
    case Salami
    case Mushroom
    case Hawaiian
    
    
    // MARK: - Constants
    
    static let All = [Burnt, Tomato, Pepper, Salami, Mushroom, Hawaiian]
    
    
    
    // MARK: - Properties
    
    /// A number indicating the priority of appearance of a pizza.
    /// The higher the number the more often the pizza should appear.
    var priority : Int {
        
        switch ( self ) {
            
        case .Tomato, .Mushroom, .Salami:
            return 5
        case .Pepper, .Hawaiian:
            return 4
        case .Burnt:
            return 2
            
        }
        
    }
    
    var score : Int {
        
        switch ( self ) {
            
        case .Burnt:
            return -100
        default:
            return 10 * topping.reduce(0, combine: { $0 + $1.score })
            
        }
        
    }
    
    var topping : [Topping] {
        
        switch ( self ) {
            
        case .Burnt:
            return []
            
        case .Tomato:
            return [.Tomato]
            
        case .Pepper:
            return [.Tomato, .Pepper]
            
        case .Salami:
            return [.Salami]
            
        case .Mushroom:
            return [.Mushroom, .Pepper, .Ham]
            
        case .Hawaiian:
            return [.Pineapple, .Ham]
            
            
        }
        
    }
    
    var image : String {
        
        switch ( self ) {
        case Burnt:
            return "BurntPizza"
        case Tomato:
            return "TomatoPizza"
        case Pepper:
            return "PepperPizza"
        case Salami:
            return "SalamiPizza"
        case Mushroom:
            return "MushroomPizza"
        case Hawaiian:
            return "HawaiianPizza"
        }
        
    }
    
    
    
    // MARK: - Functions
    
    static func random() -> Pizza {
        
        var all : [Pizza] = []
        
        for pizza in All {
            
            for _ in 0..<pizza.priority {
                all.append(pizza)
            }
            
        }
        
        return all[Int.random(all.count)]
        
    }
    
}
