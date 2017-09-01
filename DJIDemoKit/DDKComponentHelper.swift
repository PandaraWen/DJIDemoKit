//
//  DDKComponentHelper.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import DJISDK

class DDKComponentHelper {
    class func fetchProduct() -> DJIBaseProduct? {
        return DJISDKManager.product()
    }
    
    class func fetchAircraft() -> DJIAircraft? {
        return self.fetchProduct() as? DJIAircraft
    }
    
    class func fetchHandheld() -> DJIHandheld? {
        return self.fetchProduct() as? DJIHandheld
    }
    
    class func fetchCamera() -> DJICamera? {
        return self.fetchProduct()?.camera
    }
    
    class func fetchGimbal() -> DJIGimbal? {
        return self.fetchProduct()?.gimbal
    }
    
    class func fetchFlightController() -> DJIFlightController? {
        return self.fetchAircraft()?.flightController
    }
    
    class func fetchRemoteController() -> DJIRemoteController? {
        return self.fetchAircraft()?.remoteController
    }
    
    class func fetchBattery() -> DJIBattery? {
        return self.fetchProduct()?.battery
    }
    
    class func fetchAirLink() -> DJIAirLink? {
        return self.fetchAircraft()?.airLink
    }
    
    class func fetchHandheldController() -> DJIHandheldController? {
        return self.fetchHandheld()?.handheldController
    }
    
    class func fetchMobileRemoteController() -> DJIMobileRemoteController? {
        return self.fetchAircraft()?.mobileRemoteController
    }
}
