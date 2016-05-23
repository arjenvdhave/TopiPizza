//
//  StringExtensions.swift
//  TopiPizza
//
//  Created by Thomas Dekker on 23-05-16.
//  Copyright © 2016 Topicus. All rights reserved.
//

import Foundation

extension String {
    
    /// The number of characters in the string.
    var length : Int {
        return characters.count
    }
    
    /// Creates a string by applying the given padding to the left of the string.
    /// The minimal length of the returned string is the given length.
    /// - Parameter padding: The padding to apply.
    /// - Parameter length: The minimal length of the returned string.
    /// - Returns: A string with the padding applied.
    func leftPadding(padding: String, length: Int) -> String {
        
        var padded = self
        
        while ( padded.length < length ) {
            padded = padding + padded
        }
        
        return padded
        
    }
    
}
