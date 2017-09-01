//
//  DDKConfig.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/9/1.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import UIKit
import DJISDK

public class DDKConfig: NSObject {
    public static let `default` = DDKConfig()
    
    fileprivate(set) var enableBridger = false
    fileprivate(set) var bridgerIP = ""
    
    fileprivate(set) var enableRemoteLog = false
    
    func enableRemoteLog(ip: String, port: String) {
        self.enableRemoteLog = true
        let urlStr = "http://\(ip):\(port)"
        DJIRemoteLogger.configureLogger(withDeviceId: UIDevice.current.name, urlString: urlStr, showLogInConsole: true)
    }
    
    func enableBridger(ip: String) {
        self.enableBridger = true
        self.bridgerIP = ip
    }
}
