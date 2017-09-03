//
//  DDKHelper.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit

public class DDKHelper {
    public class func showAlert(title: String?, message: String?, at viewCon: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewCon.present(viewCon, animated: true, completion: nil)
    }
    
    public class func resourceBunde() -> Bundle? {
        let frameworkBundle = Bundle(for: DDKStartViewController.self)
        if let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("DDKResource.bundle") {
            let resourceBundle = Bundle(url: bundleURL)
            return resourceBundle
        }
        
        return nil
    }
}
