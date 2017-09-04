//
//  UIColor+DDKExtension.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/9/3.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit

extension UIColor {
    public class var ddkVIBlue: UIColor {
        return UIColor(r: 0, g: 140, b: 255, a: 1)
    }
    
    public convenience init(r: Int, g: Int, b: Int, a: Float) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
}
