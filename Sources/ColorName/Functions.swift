//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 4/8/22.
//

import Foundation
import CoreGraphics

func getName(for color: CGColor) -> String {
    guard let colorComponents = color.components else { fatalError("Could not find color components") }
    
    let red = Int(colorComponents[0] * 255)
    let green = Int(colorComponents[1] * 255)
    let blue = Int(colorComponents[2] * 255)
    
    let colorNames = readFromFile()
    
    var selectedColor = colorNames[0]
    var priorDistance = Int.max
    
    for colorName in colorNames {
        
        let redDifference = abs(Int(colorName.red)! - red)
        let greenDifference = abs(Int(colorName.green)! - green)
        let blueDifference = abs(Int(colorName.blue)! - blue)
        
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

#if canImport(SwiftUI)
import SwiftUI

@available(macOS 11, *)
@available(iOS 14.0, *)
func getName(for color: Color) -> String {
    getName(for: color.cgColor!)
}

#endif

#if canImport(UIKit)
import UIKit

func getName(for color: UIColor) -> String {
    getName(for: color.cgColor)
}
#endif

func readFromFile() -> [ColorName] {
    let decoder = JSONDecoder()
    
    let bundleURL = Bundle.main.url(forResource: "data", withExtension: "json")
    
    let decodedData = try? decoder.decode([ColorName].self, from: Data(contentsOf: bundleURL!))
    
    return decodedData!
}
