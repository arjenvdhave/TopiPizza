//
//  PizzaGame.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 18-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

public class PizzaGame : PizzaSceneDelegate {
    
    // MARK: - Constants
    
    private struct Constants {
        
        static let ComboMultiplier = 2
        
        /// The interval in seconds in which a combo can be made.
        static let ComboInterval = 1.0
        
        /// The maximum amount of pizzas thrown at the same time.
        static let MaxPizzaCount = 8
        
        /// The minimum delay between throwing streaks in milliseconds.
        static let MinThrowDelay = 2000
        
        /// The maximum delay between throwing streaks in milliseconds.
        static let MaxThrowDelay = 4000
        
        static let MinScore = 0
        
        static let MaxScore = 999999
        
    }
    
    
    // MARK: Private Properties
    
    private var score = Constants.MinScore {
        didSet{
            if ( score < Constants.MinScore ) {
                score = Constants.MinScore
            } else if ( score > Constants.MaxScore ) {
                score = Constants.MaxScore
            }
        }
    }
    
    private var lastCutTime = 0.0
    private var lastThrowTime = 0.0
    private var throwDelay = 0.0
    private var pizzaCount = 1
    private var lastComboMultiplier = 1
    
    
    
    // MARK: - Functions
    
    // MARK: PizzaSceneDelegate Functions
    
    func sceneDidStart(scene: PizzaScene) {
        
        
        
    }
    
    func scene(scene: PizzaScene, didPressKey key: Key) {
        
        
        
    }
    
    func scene(scene: PizzaScene, didUpdateTime time: Double) {
        
        if ( time > ( lastThrowTime + throwDelay ) ) {
            
            throwPizzas(scene)
            throwDelay = Double(Int.random(min: Constants.MinThrowDelay, max: Constants.MaxThrowDelay)) / 1000.0
            lastThrowTime = time
            pizzaCount = (pizzaCount + 1) % Constants.MaxPizzaCount
            
        }
        
    }
    
    func scene(scene: PizzaScene, shouldCut cut: Cut) -> Bool {
        
        return true
        
    }
    
    func scene(scene: PizzaScene, didCutPizza pizza: Pizza, intoSlices slices: [Slice]) -> Int {
        
        var cutScore = pizza.score
        
        let combo = (scene.time - lastCutTime) < Constants.ComboInterval
        if ( combo ) {
            cutScore *= lastComboMultiplier
            lastComboMultiplier *= Constants.ComboMultiplier
        } else {
            lastComboMultiplier = Constants.ComboMultiplier
        }
        
        score += cutScore
        scene.score = String(score).leftPadding("0", length: 6)
        lastCutTime = scene.time
        
        return cutScore
        
    }
    
    
    
    // MARK: - Private Functions
    
    private func throwPizzas(scene: PizzaScene) {
        
        for _ in 0..<pizzaCount {
            scene.throwPizza(Pizza.random())
        }
        
    }
    
}
