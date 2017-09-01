//
//  DDKLog.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import Foundation

func ddkLog(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log(message, file: file, function: function, line: line)
}

func ddkLogOK(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("💚\(message)", file: file, function: function, line: line)
}

func ddkLogInfo(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("🔵\(message)", file: file, function: function, line: line)
}

func ddkLogError(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("🔴\(message)", file: file, function: function, line: line)
}

func ddkLogWarning(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDKLogger.shareLogger.log("💛\(message)", file: file, function: function, line: line)
}

class DDKLogger: NSObject {
    static let shareLogger: DDKLogger = DDKLogger()
    
    func log(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let fileName = (String(describing: file) as NSString).lastPathComponent
        let logMsg = "\n\(fileName).\(function).line\(line):\n\(message)"
        
        if DDKConfig.default.enableRemoteLog {
            logDebug(logMsg)
        } else {
            NSLog(logMsg)
        }
    }
}
