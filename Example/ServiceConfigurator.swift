//
//  ServiceConfigurator.swift
//  Example
//
//  Created by Tomasz Lewandowski on 01/02/2020.
//  Copyright © 2020 LionSoftware.org. All rights reserved.
//

import Injector

struct ServiceConfigurator {
    static func configure(injector: Injector) throws {
        _ = try? Environment.services
            .register(as: PServiceA.self, injectable: .singleton(ServiceA()))
            .register(as: PServiceB.self, injectable: .factory({ ServiceB() }))
    }
}
