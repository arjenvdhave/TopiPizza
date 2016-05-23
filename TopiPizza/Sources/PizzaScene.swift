//
//  PizzaScene.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 12-05-16.
//  Copyright (c) 2016 Topicus. All rights reserved.
//

import SpriteKit

final class PizzaScene : SKScene {
    
    // MARK: - Private Properties
    
    private var scoreLabel : SKLabelNode? {
        return childNodeWithName("ScoreLabel") as? SKLabelNode
    }
    
    private var drag : CGPoint?
    
    private var nodes : [PizzaNode] {
        return children.flatMap({ $0 as? PizzaNode })
    }
    
    
    
    // MARK: - Properties
    
    weak var pizzaDelegate : PizzaSceneDelegate?
    
    /// The score displayed in the scene.
    var score : String {
        
        get {
            return scoreLabel?.text ?? ""
        }
        set {
            scoreLabel?.text = newValue
        }
        
    }
    
    /// The current interval in seconds from now to the start of the scene.
    private(set) var time : Double = 0
    
    
    // MARK: - Functions
    
    /// Throws the pizza into the scene.
    func throwPizza(pizza: Pizza) {
        
        let node = PizzaNode(pizza: pizza)
        
        let x = CGFloat(Int.random(
            min: Int(PizzaNode.Radius),
            max: Int(size.width - PizzaNode.Radius)
        ))
        
        node.position = CGPoint(
            x: x,
            y: -(PizzaNode.Diameter - 10)
        )
        
        
        let offset = ((size.width / 2) - x) / 2
        
        node.physicsBody?.velocity = CGVector(dx: offset, dy: 1400)
        node.physicsBody?.angularVelocity = CGFloat(Int.random(2))
        
        addChild(node)
        
    }
    
    
    
    // MARK: SKScene Functions
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        pizzaDelegate?.sceneDidStart(self)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        for node in nodes {
            
            if ( node.frame.origin.y < frame.expand(PizzaNode.Diameter).origin.y ) {
                node.removeFromParent()
            }
            
        }
        
        time = Double(currentTime)
        pizzaDelegate?.scene(self, didUpdateTime: time)
        
    }
    
    
    // MARK: NSResponder Functions
    
    override func keyDown(event: NSEvent) {
        
        if let key = event.key {
            pizzaDelegate?.scene(self, didPressKey: key)
        }
        
    }

    override func mouseDown(event: NSEvent) {
        
        drag = event.locationInNode(self)
        
    }
    
    override func mouseUp(event: NSEvent) {
        
        if let drag = drag {
            
            let cut = Cut(from: drag, to: event.locationInNode(self))
            
            if ( pizzaDelegate?.scene(self, shouldCut: cut) == true ) {
                
                let cutNode = CutNode(cut: cut)
                
                addChild(cutNode)
                
                nodes.forEach({
                    
                    let sliceNodes = $0.cut(from: cut.from, to: cut.to)
                    let slices = sliceNodes.flatMap({ $0.slice })
                    
                    if let pizza = $0.pizza where !slices.isEmpty {
                        
                        sliceNodes.forEach(addChild)
                        
                        if let score = pizzaDelegate?.scene(self, didCutPizza: pizza, intoSlices: slices) {
                            createScore(score, at: $0.position)
                        }
                        
                        $0.removeFromParent()
                        
                    }
                    
                })
                
                cutNode.runAction(
                    SKAction.fadeOutWithDuration(0.5),
                    completion: {
                        cutNode.removeFromParent()
                    }
                )
                
            }
            
        }
        
    }
    
    
    
    // MARK: - Private Functions
    
    private func createScore(score: Int, at: CGPoint) {
        
        let positive = score > 0
        var scoreText = String(score)
        
        if ( positive ) {
            scoreText = "+" + scoreText
        }
        
        let label = SKLabelNode(text: scoreText)
        label.fontName = "Monaco"
        label.fontSize = 30
        label.fontColor = positive ? SKColor.positiveColor : SKColor.negativeColor
        label.verticalAlignmentMode = .Bottom
        label.horizontalAlignmentMode = .Center
        
        var position = at
        position.x += PizzaNode.Radius
        label.position = position
        label.zPosition = 10
        
        addChild(label)
        
        label.runAction(
            SKAction.sequence([
                SKAction.fadeInWithDuration(0.2),
                SKAction.group([
                    SKAction.moveByX(0, y: 100, duration: 1),
                    SKAction.fadeOutWithDuration(1)
                ])
            ]),
            completion: {
                label.removeFromParent()
            }
        )
        
    }
    
}
