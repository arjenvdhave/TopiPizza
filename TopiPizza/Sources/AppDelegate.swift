//
//  AppDelegate.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 12-05-16.
//  Copyright (c) 2016 Topicus. All rights reserved.
//

import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - Properties
    
    @IBOutlet private weak var spriteView: SKView?
    
    //TODO: Remove after creating PizzaGame
    //private var game = PizzaGame()
    
    
    
    // MARK: - Functions
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        if let scene = PizzaScene(fileNamed:"PizzaScene"), spriteView = spriteView {
            
            //TODO: Remove after creating PizzaGame
            //scene.pizzaDelegate = game
            
            scene.scaleMode = .AspectFit
            spriteView.presentScene(scene)
            
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
}
