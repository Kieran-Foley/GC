//
//  Theme.swift
//  GCSoundboard
//
//  Created by Kieran Foley on 28/06/2018.
//  Copyright © 2018 Kieran. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let CG_PINK = GetPink()
    
    class func fromHex(_ value: Int) -> UIColor {
        return fromHex(value, alpha: 1.0)
    }
    
    class func fromHex(_ value: Int, alpha: Float) -> UIColor {
        let red: CGFloat = CGFloat((value >> 16) & 0xff)
        let green: CGFloat = CGFloat((value >> 8) & 0xff)
        let blue: CGFloat = CGFloat(value & 0xff)
        
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: CGFloat(alpha))
    }
    
    class func GetPink() -> UIColor {
        return fromHex(0xff1493)
    }
}
