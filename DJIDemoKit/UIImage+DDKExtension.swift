//
//  UIImage+DDKExtension.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/9/3.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit

extension UIImage {
    public class func image(of color: UIColor, with size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        } else {
            UIGraphicsEndImageContext()
            return nil
        }
    }
}
