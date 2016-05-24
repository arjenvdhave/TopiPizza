//
//  NSImageExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 13-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Cocoa

extension NSImage {
    
    // MARK: - Properties
    
    var frame : CGRect {
        
        return CGRect(origin: CGPoint(), size: size)
        
    }
    
    
    
    // MARK: - Functions
    
    /// Creates an image of the same size with the given path cut out.
    func cut(path: CGPath) -> NSImage {
        
        return NSImage.create(size, {
            context in
            
            CGContextAddPath(context, path)
            CGContextClip(context)
            
            var imageFrame = frame
            let imageSource = CGImageForProposedRect(
                &imageFrame,
                context: NSGraphicsContext(CGContext: context, flipped: true),
                hints: nil
            )
            
            CGContextDrawImage(context, frame, imageSource)
            
        })
    
    }

    /// Crops the image to the given frame.
    func crop(frame: NSRect) -> NSImage {
        
        let image = NSImage(size: frame.size)
        
        if ( frame.area > 0 ) {
            
            image.lockFocus()
            drawAtPoint(NSPoint(), fromRect: frame, operation: .CompositeCopy, fraction: 1)
            image.unlockFocus()
            
        }
        
        return image
        
    }
    
    
    
    // MARK: - Private Functions
    
    /// Creates a new image with the given size, performing the given drawing procedures.
    private static func create(size: CGSize, @noescape _ drawing: ((CGContext) -> ())) -> NSImage {
        
        let image : NSImage
        
        if let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, CGColorSpaceCreateDeviceRGB(), CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue) {
            
            drawing(context)
            
            if let drawn = CGBitmapContextCreateImage(context) {
                image = NSImage(CGImage: drawn, size: size)
            } else {
                image = NSImage()
            }
            
        } else {
            image = NSImage()
        }
        
        return image
        
    }
    
}
