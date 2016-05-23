//
//  CutNode.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 12-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import SpriteKit

final class PizzaNode : SKSpriteNode {
    
    // MARK: - Constants
    
    static let Radius : CGFloat = 100
    static let Diameter = 2 * Radius
    static let Size = CGSize(width: 200, height: 200)
    static let Center = CGPoint(x: Radius, y: Radius)
    static let ZeroAnglePoint = CGPoint(x: PizzaNode.Diameter, y: PizzaNode.Radius)
    static let FullAngle : Angle = .Degrees(360)
    
    
    
    // MARK: - Private Properties
    
    private var begin = CGPoint()
    private var end = CGPoint()
    
    private var path : CGMutablePath?
    private var clockwise = true
    
    
    
    // MARK: - Properties
    
    /// The pizza that this node represents.
    private(set) var pizza : Pizza?
    
    
    private(set) var fromAngle : Angle = .Degrees(0)
    private(set) var toAngle : Angle = PizzaNode.FullAngle
    
    /// The angle of the pizza slice this node represents.
    var angle : Angle {
        
        return .Degrees(toAngle.degrees - fromAngle.degrees)
        
    }
    
    /// A flag indicating whether the node represents a slice.
    var isSlice : Bool {
        return angle.degrees < PizzaNode.FullAngle.degrees
    }
    
    
    
    // MARK: - Construction
    
    convenience init(pizza: Pizza) {
        
        self.init(
            pizza: pizza,
            path: CGPath.circle(center: PizzaNode.Center, radius: PizzaNode.Radius),
            fromAngle: Angle(),
            toAngle: PizzaNode.FullAngle
        )
        
    }
    
    convenience init(pizza: Pizza, begin: CGPoint, end: CGPoint, clockwise: Bool, velocity: CGVector) {
        
        var fromAngle = PizzaNode.circleAngle(end)
        var toAngle = PizzaNode.circleAngle(begin)
        var begin = begin
        var end = end
        
        if ( fromAngle.degrees > toAngle.degrees ) {
            swap(&fromAngle, &toAngle)
            swap(&begin, &end)
        }
        
        self.init(
            pizza: pizza,
            path: CGPath.pie(
                center: PizzaNode.Center,
                radius: PizzaNode.Radius,
                fromAngle: fromAngle,
                toAngle: toAngle,
                offsetAngle: Angle(),
                clockwise: clockwise
            ),
            fromAngle: fromAngle,
            toAngle: toAngle
        )
        
        self.begin = begin
        self.end = end
        self.clockwise = clockwise
        
        if let body = physicsBody {
            
            body.velocity = CGVector(
                length: velocity.length,
                angle: .Degrees((angle.degrees / 2) * ( clockwise ? -1 : 1 ))
            )
            
        }
        
    }
    
    convenience init(pizza: Pizza, path: CGMutablePath, fromAngle: Angle, toAngle: Angle) {
        
        // TODO: Switch comment after implementing `pizza.image`
        let imageName = "PepperPizza"
        //let imageName = pizza.image
        let image = NSImage(named: imageName)?.cut(path) ?? NSImage()
        
        self.init(texture: SKTexture(image: image))
        
        self.path = path
        self.fromAngle = fromAngle
        self.toAngle = toAngle
        self.pizza = pizza
        
        physicsBody = SKPhysicsBody(polygonFromPath: CGPathCreateMutableCopy(path) ?? path)
        anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    
    
    
    // MARK: - Functions
    
    /// Performs a cut from and to the given point.
    /// - Returns: The newly created nodes that represent the slices if applicable.
    func cut(from from: CGPoint, to: CGPoint) -> [PizzaNode] {
        
        var slices : [PizzaNode] = []
        
        if let parent = parent, path = path {
            
            let a = parent.convertPoint(from, toNode: self)
            let b = parent.convertPoint(to, toNode: self)
            
            let distFT = b.distance(a)
            
            let d = CGPoint(
                x: ( b.x - a.x ) / distFT,
                y: ( b.y - a.y ) / distFT
            )
            let t = d.x * ( PizzaNode.Center.x - a.x ) + d.y * ( PizzaNode.Center.y - a.y )
            let e = CGPoint(
                x: t*d.x + a.x,
                y: t*d.y + a.y
            )
            let distEC = PizzaNode.Center.distance(e)
            
            let line = CGPath.line(from: a, to: b)
            
            if ( distEC < PizzaNode.Radius ) {
                
                let dt = sqrt( pow(PizzaNode.Radius, 2) - pow( distEC, 2 ) )
                
                let first = CGPoint(
                    x: (t - dt)*d.x + a.x,
                    y: (t - dt)*d.y + a.y
                )
                let second = CGPoint(
                    x: (t + dt)*d.x + a.x,
                    y: (t + dt)*d.y + a.y
                )
                
                if ( isSlice && ( path.near(line) ) ) {
                    
                    var begin = self.begin
                    var end = self.end
                    
                    if ( !clockwise ) {
                        swap(&begin, &end)
                    }
                    
                    for half in [first, second] {
                        
                        let offsetAngle = PizzaNode.FullAngle.degrees - PizzaNode.circleAngle(begin).degrees
                        let fromAngle : CGFloat = 0
                        let halfAngle = (PizzaNode.circleAngle(half).degrees + offsetAngle) % PizzaNode.FullAngle.degrees
                        let toAngle = PizzaNode.circleAngle(end).degrees + offsetAngle
                        
                        let contains = path.contains(half)
                        
                        if ( contains && halfAngle > fromAngle && halfAngle < toAngle ) {
                            
                            let sliceOneClockwise = halfAngle > offsetAngle
                            let sliceTwoClockwise = clockwise ? !sliceOneClockwise : sliceOneClockwise
                            
                            slices = [
                                createSlice(from: half, to: begin, clockwise: sliceOneClockwise),
                                createSlice(from: half, to: end, clockwise: sliceTwoClockwise)
                            ]
                            
                            break
                            
                        }
                        
                    }
                    
                } else if ( path.near(line) && !path.contains(a) && !path.contains(b) ) {
                    
                    slices = [
                        createSlice(from: second, to: first, clockwise: false),
                        createSlice(from: second, to: first, clockwise: true)
                    ]
                    
                }
                
            }
            
        }
        
        return slices
        
    }
    
    

    // MARK: - Private Functions
    
    private func createSlice(from from: CGPoint, to: CGPoint, clockwise: Bool) -> PizzaNode {
        
        let velocity = physicsBody?.velocity ?? CGVector()
        
        let node : PizzaNode
        
        if let pizza = pizza {
            
            node = PizzaNode(
                pizza: pizza,
                begin: from,
                end: to,
                clockwise: clockwise,
                velocity: velocity
            )
            
            node.position = position
            node.zRotation = zRotation
            
        } else {
            node = PizzaNode()
        }
        
        return node
        
    }
    
    private static func circleAngle(point: CGPoint) -> Angle {
        
        var degrees = PizzaNode.ZeroAnglePoint.angle(point, center: PizzaNode.Center).degrees
        
        if ( point.y > PizzaNode.Center.y ) {
            degrees = PizzaNode.FullAngle.degrees - degrees
        }
        
        return Angle.Degrees(degrees)
        
    }
    
}
