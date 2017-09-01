//
//  DDKLog.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import Foundation

public func ddkLog(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log(message, file: file, function: function, line: line)
}

public func ddkLogOK(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("💚\(message)", file: file, function: function, line: line)
}

public func ddkLogInfo(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("🔵\(message)", file: file, function: function, line: line)
}

public func ddkLogError(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("🔴\(message)", file: file, function: function, line: line)
}

public func ddkLogWarning(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("💛\(message)", file: file, function: function, line: line)
}

public class DDKLogger: NSObject {
    public static let shareLogger: DDKLogger = DDKLogger()
    
    public func log(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let fileName = (String(describing: file) as NSString).lastPathComponent
        let logMsg = "\n\(fileName).\(function).line\(line):\n\(message)"
        
        if DDKConfig.default.enableRemoteLog {
            logDebug(logMsg)
        } else {
            NSLog(logMsg)
        }
    }
}
