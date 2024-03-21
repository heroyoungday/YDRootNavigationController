//
//  UIColor+Extension.swift
//  YDRootNavigationController_Example
//
//  Created by One on 2024/3/20.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex string: String, alpha a: CGFloat = 1.0) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6 || hex.count == 8 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        var alpha: CGFloat = a
        
        if hex.count == 8 {
            let alphaHex = hex.subString(to: 1)
            guard let alphaCode = Int(alphaHex, radix: 16) else {
                self.init(white: 1.0, alpha: 0.0)
                return
            }
            alpha = CGFloat((alphaCode) & 0xFF) / 255.0
            hex = hex.subString(from: 2)
        }
        
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        guard let intCode = Int(hex, radix: 16) else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        self.init(
            red: CGFloat((intCode >> 16) & 0xFF) / 255.0,
            green: CGFloat((intCode >> 8) & 0xFF) / 255.0,
            blue: CGFloat((intCode) & 0xFF) / 255.0, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
    
extension String {
    func subString(to end: Int) -> String {
        guard end > 0 else { return "" }
        guard end <= count else { return self }
        return String(prefix(upTo: index(startIndex, offsetBy: end)))
    }
    
    func subString(from start: Int) -> String {
        guard start <= count else { return "" }
        return String(suffix(from: index(startIndex, offsetBy: start - 1)))
    }
}
