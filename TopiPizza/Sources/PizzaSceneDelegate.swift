//
//  PizzaSceneDelegate.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 18-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

protocol PizzaSceneDelegate : AnyObject {
    
    /// Called when the scene started rendering.
    func sceneDidStart(scene: PizzaScene)
    
    /// Called when the scene received a key press.
    func scene(scene: PizzaScene, didPressKey key: Key)
    
    /// Called when the scene updated one frame at the given time.
    /// - Parameter time: The interval in seconds from now to the start of the scene.
    func scene(scene: PizzaScene, didUpdateTime time: Double)
    
    /// Called when the scene asks if it should apply the given cut.
    /// A cut is for instance not allowed if the player received a penalty.
    /// - Returns: A flag indicating whether the cut is allowed (`true`) or not (`false`).
    func scene(scene: PizzaScene, shouldCut cut: Cut) -> Bool
    
    /// Called right after the scene performed a cut.
    /// - Returns: The score that the cut was worth.
    // TODO: Remove comment after implementing `Slice`
    // func scene(scene: PizzaScene, didCutPizza pizza: Pizza, intoSlices slices: [Slice]) -> Int
    
}
