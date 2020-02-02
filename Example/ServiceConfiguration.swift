//
//  ServiceConfiguration.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct ServiceConfiguration {
    @Registered(asType: PServiceA.self, inInjector: Environment.services)
    var serviceAInjection = Injection<PServiceA>.singleton(ServiceA()).any()
    
    @Registered(asType: PServiceB.self, inInjector: Environment.services)
    var serviceBInjection = Injection<PServiceB>.factory({ ServiceB() }).any()
}
