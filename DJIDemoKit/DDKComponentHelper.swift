//
//  DDKComponentHelper.swift
//  DJIDemoKitDemo
//
//  Created by Pandara on 2017/8/31.
//  Copyright © 2017年 Pandara. All rights reserved.
//

import DJISDK

public class DDKComponentHelper {
    public class func fetchProduct() -> DJIBaseProduct? {
        return DJISDKManager.product()
    }
    
    public class func fetchAircraft() -> DJIAircraft? {
        return self.fetchProduct() as? DJIAircraft
    }
    
    public class func fetchHandheld() -> DJIHandheld? {
        return self.fetchProduct() as? DJIHandheld
    }
    
    public class func fetchCamera() -> DJICamera? {
        return self.fetchProduct()?.camera
    }
    
    public class func fetchGimbal() -> DJIGimbal? {
        return self.fetchProduct()?.gimbal
    }
    
    public class func fetchFlightController() -> DJIFlightController? {
        return self.fetchAircraft()?.flightController
    }
    
    public class func fetchRemoteController() -> DJIRemoteController? {
        return self.fetchAircraft()?.remoteController
    }
    
    public class func fetchBattery() -> DJIBattery? {
        return self.fetchProduct()?.battery
    }
    
    public class func fetchAirLink() -> DJIAirLink? {
        return self.fetchAircraft()?.airLink
    }
    
    public class func fetchHandheldController() -> DJIHandheldController? {
        return self.fetchHandheld()?.handheldController
    }
    
    public class func fetchMobileRemoteController() -> DJIMobileRemoteController? {
        return self.fetchAircraft()?.mobileRemoteController
    }
}
