//
//  ServiceAssembly.swift
//  appointment
//
//  Created by Zhengyuan Jin on 2015-02-24.
//  Copyright (c) 2015 eWorkspace Solutions Inc. All rights reserved.
//

import Foundation
import Typhoon

public class ServiceAssembly: TyphoonAssembly {
    
    public dynamic func appointmentClient() -> AnyObject {
        return TyphoonDefinition.withClass(AppointmentServiceImpl.self) {
            (definition) in
            
            definition.injectProperty("serviceUrl", with:TyphoonConfig("service.url"))
            definition.injectProperty("apiKey", with:TyphoonConfig("api.key"))
            definition.injectProperty("appointmentDao", with:self.appointmentDao())
            definition.injectProperty("daysToRetrieve", with:TyphoonConfig("appts.to.retrieve"))
        }
    }
    
    public dynamic func appointmentDao() -> AnyObject {
    
        return TyphoonDefinition.withClass(AppointmentDacImpl.self) {
            (definition) in
            
            definition.useInitializer("initWithDefaults:") {
                (initializer) in
                
                initializer.injectParameterWith(NSUserDefaults.standardUserDefaults())
            }
        }
    }

    
}

