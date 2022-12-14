//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 4/8/22.
//

import Foundation
import CoreGraphics

public func getName(for color: CGColor) -> String {
    guard let colorComponents = color.components else { fatalError("Could not find color components") }
    
    let red = Int(colorComponents[0] * 255)
    let green = Int(colorComponents[1] * 255)
    let blue = Int(colorComponents[2] * 255)
    
    let colorNames = ColorName.colors
    
    var selectedColor = colorNames[0]
    var priorDistance = Int.max
    
    for colorName in colorNames {
        
        let redDifference = abs(colorName.red - red)
        let greenDifference = abs(colorName.green - green)
        let blueDifference = abs(colorName.blue - blue)
        
        let distance = redDifference + greenDifference + blueDifference
        
        if priorDistance > distance {
            priorDistance = distance
            selectedColor = colorName
           
            // End early if the color is close enough
            if distance < 5 { break }
        }
    }
    
    return selectedColor.name
}

#if canImport(UIKit)
import UIKit

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 14.0, *)
public func getName(for color: Color) -> String {
    getName(for: UIColor(color))
}

#endif

public func getName(for color: UIColor) -> String {
    getName(for: color.cgColor)
}
#endif
