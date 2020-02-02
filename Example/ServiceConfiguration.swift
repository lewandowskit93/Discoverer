//
//  ServiceConfiguration.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Discoverer

struct ServiceConfiguration {
    @Registered(inInjector: Environment.services)
    var serviceAInjection = Injection<PServiceA>.singleton(ServiceA())
    
    @Registered(inInjector: Environment.services)
    var serviceBInjection = Injection<PServiceB>.factory({ ServiceB() })
}
